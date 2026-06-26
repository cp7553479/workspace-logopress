#!/usr/bin/env bash
#
# logopress workspace daily sync (方案 A)
#
# 语义：macmini 分支是「本地最新版本」的权威轨迹；main 是它的镜像。
#   - 每轮：在 macmini 上 add/commit 本地改动（含未跟踪文件）→ 拉取远端
#     main → 在 macmini 上合并 main（冲突以 macmini 本地最新为准）→ main ff 到 macmini。
#   - macmini 始终等于本地最新状态；main 随其齐平。被覆盖的冲突版本仍可在
#     `git log macmini` / `git log main` 的历史提交里翻到。
#
# 关键顺序：先把本地改动提交进 macmini（让工作区变干净），再去 fetch/pull
# 远端 main。否则未跟踪文件会让 `git pull` 因「工作区会被覆盖」而中止。
#
# 设计要点：
#   * GIT_TERMINAL_PROMPT=0 — 避免凭据提示卡住 cron 运行；推送通过全局
#     `gh auth git-credential` helper 完成（token 含 repo scope）。
#   * .gitignore 无法按文件大小排除，因此先 `git add -A`，再用
#     `git cat-file -s` 检测暂存区里超过 20MB 的 blob 并 `git reset` 移出。
#   * 合并方向 main→macmini，冲突时 `git checkout --ours .`（ours=macmini=本地最新）。
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

# 1) 确保 macmini 分支存在（不存在则从 main 派生）并切过去
git fetch --all --prune
if ! git show-ref --verify --quiet refs/heads/macmini; then
  echo "[sync] creating local macmini branch from main"
  git branch macmini origin/main
fi
git checkout macmini

# 2) 暂存所有本地变更（含未跟踪文件），尊重 .gitignore（*.log 等已被忽略）
git add -A

# 3) 排除超过 20MB 的文件：扫描暂存区，过大者移出暂存区
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

# 4) 提交本地改动（仅当有暂存变更）——此时工作区变干净
if git diff --cached --quiet; then
  echo "[sync] nothing to commit"
else
  git commit -m "chore(logopress): auto-sync $(date -u +%FT%TZ)"
fi

# 5) 把本地 main 对齐到远端 main 最新（此时工作区干净，pull 不会被未跟踪文件阻塞）
git checkout main
git pull --ff-only "$ORIGIN" main
git checkout macmini

# 6) 方案 A：在 macmini 上合并 main（而非反过来），冲突以 macmini 本地最新为准。
if git merge --no-ff main -m "merge: pull main updates into macmini (local-latest)"; then
  : # 干净合并
else
  echo "[sync] merge conflict; resolving with macmini (ours/local-latest) as source of truth"
  # 合并方向是 main→macmini，故 ours=macmini（本地最新），即「保留最新版，覆盖冲突」
  git checkout --ours .
  git add -A
  git commit --no-edit
fi

# 7) 推送 macmini（本地最新版本的权威轨迹）
git push -u "$ORIGIN" macmini

# 8) main 直接对齐 macmini（macmini 已是最新版本，main fast-forward 即可）
git checkout main
git merge --ff-only macmini
git push "$ORIGIN" main

# 9) 回到 macmini，收尾
git checkout macmini
echo "[sync] done at $(date -u +%FT%TZ)"
