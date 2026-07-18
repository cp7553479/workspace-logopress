#!/usr/bin/env bash
#
# logopress workspace daily sync (方案 A)
#
# 语义：macmini 分支是「本地最新版本」的权威轨迹；main 是它的镜像。
#   - 每轮：在 macmini 上 add/commit 本地改动（含未跟踪文件）→ 拉取远端
#     main → 在 macmini 上合并 main（冲突逐文件比较最近提交时间）→ main 对齐 macmini。
#   - macmini 始终等于本地最新状态；main 随其齐平。被覆盖的冲突版本仍可在
#     `git log macmini` / `git log main` 的历史提交里翻到。
#
# 关键顺序：先把本地改动提交进 macmini（让工作区变干净），再去 fetch/pull
# 远端 main。否则未跟踪文件会让 `git pull` 因「工作区会被覆盖」而中止。
#
# 设计要点：
#   * GIT_TERMINAL_PROMPT=0 — 避免凭据提示卡住 cron 运行；推送通过全局
#     `gh auth git-credential` helper 完成（token 含 repo scope）。
#   * `.temp` 目录由 .gitignore 排除；文件大小无法靠 .gitignore 判断，因此
#     每次 commit 前逐个检查索引中的全部 blob。超过 10MiB 的文件无论是否
#     已被 Git 跟踪，都从索引移除，但保留工作区文件。
#   * 合并方向 main→macmini；冲突逐文件比较两个分支最后一次修改该路径的
#     commit 时间，选择时间较新的版本；时间相同则保留 macmini。
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
MAX_BYTES=$((10 * 1024 * 1024))   # 10 MiB

echo "[sync] start at $(date -u +%FT%TZ) in $(pwd)"

exclude_temp_dirs_from_index() {
  local removed_files=0 path

  while IFS= read -r -d '' path; do
    case "$path" in
      .temp/*|*/.temp/*)
        git rm -q --cached --ignore-unmatch -- "$path"
        removed_files=$((removed_files + 1))
        ;;
    esac
  done < <(git ls-files -z)
  echo "[sync] removed $removed_files tracked .temp paths from Git index (worktree copies kept)"
}

exclude_large_files_from_index() {
  local checked_files=0 path sha size
  local large_files=()

  echo "[sync] scanning all indexed blobs against 10MiB limit"
  while IFS= read -r -d '' path; do
    sha="$(git rev-parse --verify ":$path" 2>/dev/null || true)"
    [ -z "$sha" ] && continue
    size="$(git cat-file -s "$sha")"
    if [ "$size" -gt "$MAX_BYTES" ]; then
      large_files+=("$path")
    fi
    checked_files=$((checked_files + 1))
    if [ $((checked_files % 500)) -eq 0 ]; then
      echo "[sync] checked $checked_files indexed blobs"
    fi
  done < <(git ls-files -z)

  if [ "${#large_files[@]}" -gt 0 ]; then
    printf '[sync] removing >10MiB files from Git index (%d, worktree copies kept):\n' "${#large_files[@]}"
    for path in "${large_files[@]}"; do
      printf '   - %s\n' "$path"
      git rm -q --cached --ignore-unmatch -- "$path"
    done
  fi
  echo "[sync] indexed blob scan complete ($checked_files checked)"
}

restore_conflict_from_branch() {
  local source_branch="$1" path="$2"
  if git cat-file -e "$source_branch:$path" 2>/dev/null; then
    git checkout "$source_branch" -- "$path"
  else
    git rm -q --ignore-unmatch -- "$path"
  fi
}

# 1) 确保 macmini 分支存在（不存在则从 main 派生）并切过去
git fetch --all --prune
if ! git show-ref --verify --quiet refs/heads/macmini; then
  echo "[sync] creating local macmini branch from main"
  git branch macmini origin/main
fi
git checkout macmini

# 2) 暂存所有本地变更（含未跟踪文件），尊重 .gitignore
echo "[sync] staging workspace changes"
git add -A

# 3) 先清掉所有层级已跟踪的 .temp，再逐个检查整个 Git 索引；已跟踪大文件也会从索引移除并形成删除记录，
#    但本地工作区副本保留。动态生成的大文件无需预先写入 .gitignore。
exclude_temp_dirs_from_index
exclude_large_files_from_index

# 4) 提交允许进入 Git 的本地改动；被排除的大文件仍留在工作区
if git diff --cached --quiet; then
  echo "[sync] nothing to commit"
else
  git commit -m "chore(logopress): auto-sync $(date -u +%FT%TZ)"
fi

# 5) 把本地 main 引用对齐到远端 main 最新，不切换工作区，避免未跟踪的大文件
#    阻塞 checkout。开头的 fetch 已刷新 origin/main。
git branch -f main "$ORIGIN/main"

# 6) main→macmini，先不提交；冲突时逐文件按最近 commit 时间选择版本。
#    Git 不保存文件 mtime，因此“最新文件”以最后一次修改该路径的 commit 时间定义。
if git merge --no-ff --no-commit main; then
  :
else
  echo "[sync] merge conflict; resolving each path by latest commit time"
  while IFS= read -r -d '' path; do
    macmini_time="$(git log -1 --format=%ct macmini -- "$path")"
    main_time="$(git log -1 --format=%ct main -- "$path")"
    macmini_time="${macmini_time:-0}"
    main_time="${main_time:-0}"
    if [ "$main_time" -gt "$macmini_time" ]; then
      echo "[sync] conflict winner main ($main_time > $macmini_time): $path"
      restore_conflict_from_branch main "$path"
    else
      echo "[sync] conflict winner macmini ($macmini_time >= $main_time): $path"
      restore_conflict_from_branch macmini "$path"
    fi
  done < <(git diff --name-only --diff-filter=U -z)
  git add -A
fi

# main 合入的内容也必须在 merge commit 生成前通过 10MiB 过滤。
if [ -f "$(git rev-parse --git-path MERGE_HEAD)" ]; then
  exclude_temp_dirs_from_index
  exclude_large_files_from_index
  git commit -m "merge: main into macmini (latest-file-wins)"
else
  echo "[sync] main already contained in macmini; no merge commit needed"
fi

# 7) 推送 macmini（本地最新版本的权威轨迹）
git push -u "$ORIGIN" macmini

# 8) main 直接对齐 macmini。无需 checkout main，避免工作区中保留的大文件阻塞切换。
git branch -f main macmini
git push "$ORIGIN" macmini:main

# 9) 当前工作区始终停留在 macmini
echo "[sync] done at $(date -u +%FT%TZ)"
