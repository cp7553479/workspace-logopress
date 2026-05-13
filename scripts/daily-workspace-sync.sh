#!/usr/bin/env bash
set -Eeuo pipefail

REPO="/Users/vincent/.openclaw/workspace-logopress"
REMOTE="origin"
LOCAL_BRANCH="local"
MAIN_BRANCH="main"
TZ_NAME="Asia/Shanghai"
NOTIFY_CHANNEL="feishu"
NOTIFY_ACCOUNT="global-trading-product"
NOTIFY_TARGET="user:ou_61123e30e1c1bfd2d0d31af923d4982d"
LOG_DIR="$HOME/.openclaw/logs"
LOG_FILE="$LOG_DIR/workspace-logopress-daily-sync.log"
WORKTREE_ROOT="$HOME/.openclaw/tmp/workspace-logopress-main-sync"
RUN_ID="$(date +%Y%m%d-%H%M%S)"
TMP_BRANCH="cron-main-merge-$RUN_ID"
WT="$WORKTREE_ROOT/$RUN_ID"

mkdir -p "$LOG_DIR" "$WORKTREE_ROOT"
exec > >(tee -a "$LOG_FILE") 2>&1

notify() {
  local title="$1"
  local body="$2"
  if command -v openclaw >/dev/null 2>&1; then
    openclaw message send \
      --channel "$NOTIFY_CHANNEL" \
      --account "$NOTIFY_ACCOUNT" \
      --target "$NOTIFY_TARGET" \
      --message "$title

$body" || true
  fi
}

cleanup() {
  set +e
  if [[ -d "$WT/.git" || -f "$WT/.git" ]]; then
    git -C "$REPO" worktree remove --force "$WT" >/dev/null 2>&1 || true
  fi
  git -C "$REPO" branch -D "$TMP_BRANCH" >/dev/null 2>&1 || true
}
trap cleanup EXIT

fail() {
  local line="$1"
  notify "workspace 自动同步失败" "时间：$(TZ="$TZ_NAME" date '+%Y-%m-%d %H:%M:%S %Z')
仓库：$REPO
失败位置：第 ${line} 行
日志：$LOG_FILE

当前 workspace 会保持在 local 分支；请检查日志。"
  exit 1
}
trap 'fail $LINENO' ERR

commit_time_for_path() {
  local ref="$1"
  local path="$2"
  local ts
  ts="$(git log -1 --format=%ct "$ref" -- "$path" 2>/dev/null || true)"
  echo "${ts:-0}"
}

# Resolve active merge conflicts file-by-file by latest commit time.
# During a merge, --ours is the checked-out branch, --theirs is the branch being merged in.
resolve_conflicts_by_latest_commit() {
  local ours_ref="$1"
  local theirs_ref="$2"
  local ours_label="$3"
  local theirs_label="$4"
  local conflicts path ours_ts theirs_ts choice

  conflicts="$(git diff --name-only --diff-filter=U || true)"
  if [[ -z "$conflicts" ]]; then
    return 0
  fi

  echo "Resolving conflicts by latest file commit time:"
  while IFS= read -r path; do
    [[ -z "$path" ]] && continue
    ours_ts="$(commit_time_for_path "$ours_ref" "$path")"
    theirs_ts="$(commit_time_for_path "$theirs_ref" "$path")"

    if [[ "$theirs_ts" -ge "$ours_ts" ]]; then
      choice="$theirs_label"
      git checkout --theirs -- "$path" 2>/dev/null || git rm -f -- "$path"
    else
      choice="$ours_label"
      git checkout --ours -- "$path" 2>/dev/null || git rm -f -- "$path"
    fi
    git add -- "$path" || true
    echo "- $path: ours=$ours_label@$ours_ts theirs=$theirs_label@$theirs_ts => keep $choice"
  done <<< "$conflicts"

  if [[ -n "$(git diff --name-only --diff-filter=U || true)" ]]; then
    echo "Some conflicts remain unresolved:"
    git diff --name-only --diff-filter=U || true
    return 1
  fi
}

merge_with_latest_conflict_policy() {
  local target_ref="$1"
  local ours_ref="$2"
  local ours_label="$3"
  local theirs_label="$4"

  set +e
  git merge --no-edit "$target_ref"
  local merge_status=$?
  set -e

  if [[ $merge_status -eq 0 ]]; then
    return 0
  fi

  resolve_conflicts_by_latest_commit "$ours_ref" "$target_ref" "$ours_label" "$theirs_label"
  git commit --no-edit
}

export TZ="$TZ_NAME"
echo "===== workspace sync start: $(date '+%Y-%m-%d %H:%M:%S %Z') ====="

cd "$REPO"

current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "$LOCAL_BRANCH" ]]; then
  echo "Current branch is '$current_branch'; switching back to '$LOCAL_BRANCH'."
  git switch "$LOCAL_BRANCH"
fi

# Bring remote refs up to date. origin/local may not exist before the first push, so fetch failures for that ref are tolerated.
git fetch "$REMOTE" "$MAIN_BRANCH"
git fetch "$REMOTE" "$LOCAL_BRANCH" || true

# Save all workspace changes before pulling main so uncommitted work participates in conflict policy.
git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: daily workspace snapshot $(date '+%Y-%m-%d %H:%M:%S %Z')"
else
  echo "No local workspace changes to snapshot."
fi

# First absorb the latest main into local. On conflict, keep the side with the latest file commit time.
merge_with_latest_conflict_policy "$REMOTE/$MAIN_BRANCH" "HEAD" "$LOCAL_BRANCH" "$MAIN_BRANCH"

git push -u "$REMOTE" "$LOCAL_BRANCH"

git fetch "$REMOTE" "$MAIN_BRANCH" "$LOCAL_BRANCH"

changed_files="$(git diff --name-status "$REMOTE/$MAIN_BRANCH".."$REMOTE/$LOCAL_BRANCH" || true)"
if [[ -z "$changed_files" ]]; then
  echo "No differences between $REMOTE/$LOCAL_BRANCH and $REMOTE/$MAIN_BRANCH."
  echo "===== workspace sync complete: $(date '+%Y-%m-%d %H:%M:%S %Z') ====="
  exit 0
fi

echo "Files differing from main:"
echo "$changed_files"

# Merge into main in a temporary worktree so the real workspace never leaves local.
git worktree add -B "$TMP_BRANCH" "$WT" "$REMOTE/$MAIN_BRANCH"
cd "$WT"

# Then merge local into main. On conflict, keep the side with the latest file commit time.
merge_with_latest_conflict_policy "$REMOTE/$LOCAL_BRANCH" "HEAD" "$MAIN_BRANCH" "$LOCAL_BRANCH"

git push "$REMOTE" HEAD:"$MAIN_BRANCH"

echo "Merged $MAIN_BRANCH -> $LOCAL_BRANCH, then $LOCAL_BRANCH -> $MAIN_BRANCH, and pushed both branches."
echo "===== workspace sync complete: $(date '+%Y-%m-%d %H:%M:%S %Z') ====="
