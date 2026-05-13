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

当前 workspace 已保持在 local 分支；没有强制合并。"
  exit 1
}
trap 'fail $LINENO' ERR

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

# Save all workspace changes on local branch.
git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: daily workspace sync $(date '+%Y-%m-%d %H:%M:%S %Z')"
else
  echo "No local workspace changes to commit."
fi

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

# Merge in a temporary worktree so the real workspace never leaves local.
git worktree add -B "$TMP_BRANCH" "$WT" "$REMOTE/$MAIN_BRANCH"
cd "$WT"

set +e
git merge --no-edit "$REMOTE/$LOCAL_BRANCH"
merge_status=$?
set -e

if [[ $merge_status -ne 0 ]]; then
  conflict_list="$(git diff --name-only --diff-filter=U || true)"
  notify "workspace 自动同步出现合并冲突" "时间：$(date '+%Y-%m-%d %H:%M:%S %Z')
仓库：$REPO
local 已推送到 GitHub，但合并 main 时发生冲突，已停止，没有强制合并。

冲突文件：
${conflict_list:-未能读取冲突文件列表}

日志：$LOG_FILE"
  exit 2
fi

git push "$REMOTE" HEAD:"$MAIN_BRANCH"

echo "Merged $LOCAL_BRANCH into $MAIN_BRANCH and pushed."
echo "===== workspace sync complete: $(date '+%Y-%m-%d %H:%M:%S %Z') ====="
