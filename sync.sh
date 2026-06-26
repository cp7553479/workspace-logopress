#!/usr/bin/env bash
#
# logopress workspace daily sync
#
# - 提交 workspace 最新更新到本地（排除超过 20MB 的文件；忽略 *.log）
# - 推送到 GitHub 的 macmini 分支
# - 合并进 main 分支（冲突以最新更新 / macmini 为准）
# - 推送 main 回 GitHub
#
# 设计要点：
#   * GIT_TERMINAL_PROMPT=0 — 避免凭据提示卡住 cron 运行；推送通过全局
#     `gh auth git-credential` helper 完成（token 含 repo scope）。
#   * .gitignore 无法按文件大小排除，因此先 `git add -A`，再用
#     `git cat-file -s` 检测暂存区里超过 20MB 的 blob 并 `git reset` 移出。
#   * 合并冲突时 `git checkout --theirs .`，theirs = macmini（最新更新）。
set -euo pipefail

export GIT_TERMINAL_PROMPT=0
# cron / 非交互环境下补一个提交身份（不影响已有的全局/仓库 config）
: "${GIT_AUTHOR_NAME:=cp7553479}"
: "${GIT_AUTHOR_EMAIL:=dedconan@gmail.com}"
: "${GIT_COMMITTER_NAME:=$GIT_AUTHOR_NAME}"
: "${GIT_COMMITTER_EMAIL:=$GIT_AUTHOR_EMAIL}"
export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

cd "$(dirname "$0")"

ORIGIN="origin"
MAX_BYTES=$((20 * 1024 * 1024))   # 20MB

echo "[sync] start at $(date -u +%FT%TZ) in $(pwd)"

# 1) 拉取远端最新，并使本地 main 与 origin/main 一致
git fetch --all --prune
git checkout main
git pull --ff-only "$ORIGIN" main

# 2) 确保 macmini 分支存在（不存在则从 main 派生）
if ! git show-ref --verify --quiet refs/heads/macmini; then
  echo "[sync] creating local macmini branch from main"
  git branch macmini main
fi

# 切到 macmini，并同步到 main 的最新基线（macmini 是本次工作分支）
git checkout macmini
if git merge --ff-only main 2>/dev/null; then
  : # macmini 可快进到 main
else
  echo "[sync] macmini cannot ff to main; resetting macmini onto main"
  git reset --hard main
fi

# 3) 暂存所有变更（含未跟踪文件），尊重 .gitignore（*.log 等已被忽略）
git add -A

# 4) 排除超过 20MB 的文件：扫描暂存区，过大者移出暂存区
large_files=()
while IFS= read -r staged_line; do
  # staged_line 形如: <mode> <sha> <stage>\t<path>
  sha="$(printf '%s' "$staged_line" | awk '{print $2}')"
  path="$(printf '%s' "$staged_line" | cut -f2-)"
  [ -z "${sha:-}" ] && continue
  size="$(git cat-file -s "$sha" 2>/dev/null || echo 0)"
  if [ "$size" -gt "$MAX_BYTES" ]; then
    large_files+=("$path")
  fi
done < <(git ls-files --cached --stage)

if [ "${#large_files[@]}" -gt 0 ]; then
  printf '[sync] skipping >20MB files (%d):\n' "${#large_files[@]}"
  for f in "${large_files[@]}"; do
    printf '   - %s\n' "$f"
  done
  printf '%s\n' "${large_files[@]}" | tr '\n' '\0' | xargs -0 -r git reset -q --
fi

# 5) 提交（仅当有暂存变更）
if git diff --cached --quiet; then
  echo "[sync] nothing to commit"
else
  git commit -m "chore(logopress): auto-sync $(date -u +%FT%TZ)"
fi

# 6) 推送 macmini 到 GitHub（首次会创建远端 macmini 分支）
git push -u "$ORIGIN" macmini

# 7) 合并进 main；冲突以 macmini（最新更新）为准
git checkout main
if git merge --no-ff macmini -m "merge: logopress auto-sync into main"; then
  : # 干净合并
else
  echo "[sync] merge conflict; resolving with macmini (theirs) as source of truth"
  git checkout --theirs .
  git add -A
  git commit --no-edit
fi
git push "$ORIGIN" main

# 8) 回到 macmini，收尾
git checkout macmini
echo "[sync] done at $(date -u +%FT%TZ)"
