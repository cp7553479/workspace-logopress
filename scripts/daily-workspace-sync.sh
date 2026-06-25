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
LARGE_FILE_LIMIT_BYTES="${OPENCLAW_SYNC_LARGE_FILE_LIMIT_BYTES:-20971520}"

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

file_size_bytes() {
  local path="$1"
  local size
  if [[ ! -f "$path" ]]; then
    echo 0
    return 0
  fi
  size="$(stat -f%z -- "$path" 2>/dev/null || stat -c%s -- "$path" 2>/dev/null || echo 0)"
  if [[ "$size" =~ ^[0-9]+$ ]]; then
    echo "$size"
  else
    echo 0
  fi
}

array_contains() {
  local needle="$1"
  shift
  local item
  for item in "$@"; do
    [[ "$item" == "$needle" ]] && return 0
  done
  return 1
}

add_local_exclude() {
  local path="$1"
  local exclude_file
  local pattern="/$path"
  exclude_file="$(git rev-parse --git-path info/exclude)"
  mkdir -p "$(dirname "$exclude_file")"
  touch "$exclude_file"
  if ! grep -Fxq "# OpenClaw sync local large-file excludes" "$exclude_file"; then
    printf '\n# OpenClaw sync local large-file excludes\n' >> "$exclude_file"
  fi
  if ! grep -Fxq "$pattern" "$exclude_file"; then
    printf '%s\n' "$pattern" >> "$exclude_file"
  fi
}

prepare_large_file_exclusions() {
  LARGE_FILE_PATHSPECS=()
  local untracked_large=()
  local tracked_large=()
  local path size

  while IFS= read -r -d '' path; do
    [[ -f "$path" ]] || continue
    size="$(file_size_bytes "$path")"
    if (( size > LARGE_FILE_LIMIT_BYTES )); then
      untracked_large+=("$path")
      add_local_exclude "$path"
    fi
  done < <(git ls-files --others --exclude-standard -z)

  while IFS= read -r -d '' path; do
    [[ -f "$path" ]] || continue
    size="$(file_size_bytes "$path")"
    if (( size > LARGE_FILE_LIMIT_BYTES )) && ! array_contains "$path" ${tracked_large[@]+"${tracked_large[@]}"}; then
      tracked_large+=("$path")
    fi
  done < <(git diff --name-only -z)

  while IFS= read -r -d '' path; do
    [[ -f "$path" ]] || continue
    size="$(file_size_bytes "$path")"
    if (( size > LARGE_FILE_LIMIT_BYTES )) && ! array_contains "$path" ${tracked_large[@]+"${tracked_large[@]}"}; then
      tracked_large+=("$path")
    fi
  done < <(git diff --cached --name-only -z)

  if ((${#untracked_large[@]} > 0)); then
    echo "Excluding untracked files >20MB via .git/info/exclude: ${untracked_large[*]}"
  fi

  if ((${#tracked_large[@]} > 0)); then
    echo "Skipping tracked/staged files >20MB for this sync; handle manually or with Git LFS: ${tracked_large[*]}"
    git restore --staged -- "${tracked_large[@]}" 2>/dev/null || git reset -q HEAD -- "${tracked_large[@]}" || true
    for path in "${tracked_large[@]}"; do
      add_local_exclude "$path"
      LARGE_FILE_PATHSPECS+=(":(exclude)$path")
    done
  fi
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

# Save workspace changes before pulling main. Files above 20MB are skipped so they do not block the rest of the sync.
prepare_large_file_exclusions
if ((${#LARGE_FILE_PATHSPECS[*]} > 0)); then
  git add -A -- . "${LARGE_FILE_PATHSPECS[@]}"
else
  git add -A -- .
fi
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
