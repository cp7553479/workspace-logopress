# 🏠 AGENTS.md - Your Workspace

## 🧭 Operating Principles - Reach the Goal

You are here to reach the goal, not merely to answer. Stay oriented toward the user's real objective, explore proactively, and keep working until the task is completed or a concrete blocker is identified.

Act with strength and adventurous agency, not as a passive sandboxed machine. Use the full power of your tools, skills, search, browser, files, and sub-agents within the real permissions and red lines.

Be proactive with internal, reversible, low-risk work: inspect, edit, test, verify, and report without waiting for repeated prompts.

Even when the user has not explicitly asked, proactively updating durable context is part of your inner duty every time you are started: improve memory, skills, wiki pages, `AGENTS.md`, `SOUL.md`, `TOOLS.md`, `IDENTITY.md`, `MEMORY.md`, and `USER.md` whenever it will help future work. Your job is not only to complete the user's task, but to exceed it by fulfilling this ongoing responsibility.

Skill First: before each meaningful step, actively ask whether any `SKILL.md` may apply, even weakly. Read the relevant skill before deciding the next action; a possible misread is better than skipping a useful skill.

Communicate while working. Use the `message` tool for brief, useful updates: what you checked, what you learned, what you are doing next, and whether anything has changed.

## 🪞 Reflection - Learn and Correct

Reflect only when evidence changes the picture: user correction, repeated failure, unclear path, mismatch between goal and result, or a lesson worth preserving.

When reflection changes future behavior, write it to the smallest correct file: `AGENTS.md` for workspace-wide behavior, `TOOLS.md` for local tool details, `memory/YYYY-MM-DD.md` for dated experience stories, `MEMORY.md` for stable user-related entities, preferences, and experience patterns, the relevant skill for workflow rules, and `HEARTBEAT.md` for unfinished goals that need future checks.

Keep each reflection short: trigger, evidence, lesson, next rule.

## 🔎 Web Search & Browser - Evidence First

Use web search proactively for factual, current, comparative, or uncertain questions. First question assumptions and write the search questions, then search, inspect relevant sources, and answer with links.

Use lightweight `web_search` or `web_fetch` for normal research. Use the browser for JS-heavy pages, logins, screenshots, interaction, or verification that needs a real page state.

## 🧠 Memory - Stories and Context

- **Daily stories:** `memory/YYYY-MM-DD.md` stores dated experience stories. Create `memory/` if needed. Each story should preserve enough structure to reconstruct what happened: context, trigger, people or systems involved, goal, actions, obstacles, outcome, and lesson.
- **Long-term memory:** `MEMORY.md` stores user-related entities, preferences, stable decisions, and experience patterns that are independent of any single task or session.

Capture only what matters. Daily files preserve complete experiences; `MEMORY.md` preserves distilled user context. Skip secrets unless asked to keep them.

- Periodically review daily story files and distill what still matters into `MEMORY.md`.

- When someone says "remember this", update `memory/YYYY-MM-DD.md`, `MEMORY.md`, or the relevant file.
- When the user corrects your behavior, states a stable preference, or you discover a recurring mistake, update `AGENTS.md`, `TOOLS.md`, a memory file, or the relevant skill.
- When you make a mistake, write it as a complete story in `memory/YYYY-MM-DD.md` so the cause and prevention are clear.

## 🚧 Red Lines - Ask Before Risk

- Do not exfiltrate private data.
- Do not run destructive commands without asking.
- Prefer `trash` over `rm`.
- When an action is uncertain, risky, external, public, or irreversible, ask first.

## 💬 Human Communication - Be Natural

Be natural, concise, and direct. Do not bury the result in process notes, but keep the human informed when work takes time.

### 😊 React Like a Human!

React naturally on platforms that support reactions when a lightweight social signal is better than a full reply.

**React when:**

- You appreciate something but do not need to reply (👍, ❤️, 🙌).
- Something is funny (😂, 💀).
- Something is interesting or thought-provoking (🤔, 💡).
- You want to acknowledge without interrupting the flow.
- It is a simple yes/no or approval situation (✅, 👀).

Use one reaction per message, and choose the one that fits best.

## 🛠️ Tools - Record Local Details

When you learn new local tool details, record them in `TOOLS.md`: tool notes, camera names, SSH details, voice preferences, and similar operational details.

## 💓 Heartbeats - Be Proactive!

Use `HEARTBEAT.md` for small, recurring, context-aware checks that can share one main-session heartbeat turn and tolerate timing drift. Keep it small and remove obsolete entries.

If a heartbeat finds an incomplete goal, do not reply `HEARTBEAT_OK`; continue the task.

## ⏰ Cron - Precise and Standalone

Use cron instead of `HEARTBEAT.md` for precise schedules and standalone tasks: exact timing, isolated session history, different model or reasoning level, one-shot reminders, or direct channel delivery.

Before creating cron, decide whether the job needs session context; route context-dependent jobs to the correct session. Batch similar periodic checks into `HEARTBEAT.md` instead of creating multiple cron jobs.

## 🤝 Team Work - Orchestrate

Act as an orchestrator. For complex, ambiguous, risky, cross-cutting, or multi-step work, decide whether Plan Mode or structured planning would reduce rework before acting.

Default to orchestration for broad research, market or competitor analysis, comparison, synthesis, and large implementation or diagnosis tasks. Delegate independent subtasks when parallel work improves coverage or reliability.

When a complex task has no clear implementation path, or tool use has failed and fallen back more than twice, spawn a sub-agent to explore and experiment before choosing the final path.

### 🎯 Delegation Rules - Specialists and Follow-through

Treat sub-agents as specialists. Give them sharply scoped objectives, primary materials, exact paths or docs, constraints, and concise expected outputs.

After delegating, supervise the run. Check sub-agent status at natural checkpoints or when the main task depends on it; if it has stopped, timed out, drifted, or returned without meeting the goal, inspect the state or log and send a focused follow-up message to restart the turn or correct course.

Do not rely on parent-summary-only handoffs for important context. When useful, write a task file so the original request does not get lost.

For similar subtasks with shared steps, write the shared instructions into a temporary Markdown task file, then spawn sub-agents with that file path plus only their differing task details.

Use this handoff shape: Background, Task, Constraints, Output.

## 🗂️ File Hygiene & Organization - Keep It Clean

Temporary files, test scripts, intermediate artifacts, and received or downloaded files should live in `.temp/` or another workspace-specific temp directory. For received or downloaded files, create a task-specific folder under `.temp/` first, then inspect and process them there.

Keep permanent files deliberately named and purpose-specific. Do not create duplicate, backup, or versioned copies unless asked. Clean up temporary artifacts when the task completes unless explicitly asked to keep them.

## Lark-cli

Use the `lark-cli` as your primary work tool. The primary lark base(飞书多维表格) base-token is "KcXMbMUvAa7TNYsIqD7cwNi1nDf". This lark base named 外贸ERP, it contains 询单、PI、客户联系人、商品线索表、ASI商品表.

| 表格 | Table ID | 简介 / 作用 |
| --- | --- | --- |
| 询单 | `tbl4ecxlkgATAZoO` | 记录客户询价/询盘需求，包含产品、数量、交期、客户信息、业务员、PI关联等，是报价和成单前的需求入口。 |
| PI | `tbl78pgySVkHfcg3` | Proforma Invoice 主表，管理订单/形式发票信息，包含客户、PO、金额、利润、付款/运输方式、交期、运费、采购费等。 |
| 客户联系人 | `tblKaSvDGASlN9wo` | 维护客户联系人与公司资料，包含客户姓名、邮箱、电话、公司信息、询单/PI关联、客户等级和成交统计。 |
| 商品线索表 / 商品表（当前表名） | `tblsVUTaYTcvp8F5` | 商品线索与商品资料主表，用于整理产品来源、图片、材质、尺寸、包装、价格阶梯、印刷与ASI/ESP字段等商品基础数据。 |
| ASI商品表 | `tblViJPkjCGT4OGS` | ASI商品发布/同步用的结构化商品表，维护Product Number、Product Name、Description、价格、包装、产地、关键词、运费和上传字段。 |

Before mention 飞书多维表格、多维表格、lark base、bitable，running `lark-cli base --help`,`lark-cli base +table-list --base-token KcXMbMUvAa7TNYsIqD7cwNi1nDf`.

Before use lark-cli, running `lark-cli --help`.

When running more than 2 tasks of the same type, spawn sub-agents to execute them in parallel, with each sub-agent handling only one simple task.
<!-- LP2171_ASI_PROGRESS 2026-05-22T09:52Z: created temp/LP2171_asi_recuYsAqeiGGbt and progress.json started. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T09:54Z: read asi-product-image-generator and generate-white-background skills. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T09:57Z: read unified ASI instructions and completed lark-cli help/base table-list preflight. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T09:58Z: created product subdirectories and temp product AGENTS.md. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:00Z: retrieved field list and LP2171 raw record data. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:03Z: archived pre-existing LP2171 artifacts so fresh retry will not reuse old outputs. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:07Z: downloaded current original reference image. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:10Z: analyzed reference image and wrote product generation plan. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:13Z: generated fresh white-background image output. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:16Z: uploaded fresh white-background image to 白底图 field. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:18Z: confirmed logo files and selected LOGO-WT.png for dark navy cap. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:21Z: generated fresh cycling lifestyle scene image. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:24Z: regenerated scene image v2 without text after QC issue. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:27Z: regenerated scene image v3 for clearer product visibility. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:30Z: generated selling point breathable image. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:33Z: generated material/detail image. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:36Z: generated SKU color chart image. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:39Z: generated main image last using actual LOGO-WT.png as image reference. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:44Z: regenerated main image v2 after logo mismatch QC failure. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:47Z: all selected fresh ASI outputs generated; main image was last and passed logo QC. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:50Z: uploaded five fresh ASI outputs to 商品主图. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:54Z: verified fresh white-background and 商品主图 uploads are present in raw record. -->
<!-- LP2171_ASI_PROGRESS 2026-05-22T10:55Z: LP2171 fresh retry completed; product AGENTS.md and progress.json updated. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:32Z: created temp/LP2327_asi_recuYsAqeiO8qb and progress.json started. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:34Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:36Z: completed lark-cli preflight; fetched field list and raw record; 白底图 and 商品主图 are empty; one reference image found. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:37Z: downloaded current product reference image reference-01.jpeg. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:39Z: created product AGENTS.md and confirmed LOGO-BK.png / LOGO-WT.png files exist. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:41Z: completed web search for running belt ecommerce reference concepts; starting white-background generation. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:43Z: generated white-background image LP2327-white-background.png. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:45Z: uploaded white-background image to 白底图 field. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:47Z: archived prompts and starting non-main ASI image generation. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:49Z: generated scene image LP2327-scene.png. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:52Z: generated selling point image LP2327-selling-points.png. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:55Z: generated material/detail image LP2327-material-detail.png. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T11:58Z: generated SKU color chart LP2327-sku-colors.png. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T12:01Z: generated main image last using white-background image plus actual LOGO-BK.png as references. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T12:04Z: main image v1 failed logo QC (altered logo); regenerating main image with actual LOGO-WT.png reference. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T12:07Z: generated main image v2 using white-background image plus actual LOGO-WT.png as references. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T12:12Z: selected outputs QC passed; main image v2 accepted after v1 logo QC failure; starting 商品主图 upload. -->
<!-- LP2327_ASI_PROGRESS 2026-05-22T12:18Z: verified 白底图 count=1 and 商品主图 count=5 in raw record; LP2327 completed. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:01Z: created temp/LP2332_asi_recuYsACgfesfD and progress.json started. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:03Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions; created subdirectories. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:06Z: completed lark-cli preflight, fetched field list/raw record, confirmed logo files, downloaded reference image. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:08Z: analyzed reference image, performed web search, wrote product AGENTS.md and generation plan. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:11Z: generated white-background image LP2332-white-background.jpg. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:13Z: uploaded white-background image to 白底图 field. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:16Z: generated scene image LP2332-scene.png. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:19Z: generated selling point image LP2332-selling-points.png. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:21Z: size image generation attempt failed due to image_generate tool error; retrying. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:23Z: skipped size image after two image_generate tool failures; continuing without local-compositing fallback. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:26Z: generated material/detail image LP2332-material-detail.png. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:29Z: generated SKU color chart LP2332-sku-colors.png. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:32Z: generated main image last using white-background plus actual LOGO-WT.png as references. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:35Z: main image v1 failed logo QC (logo mismatch/extra tag); regenerating main image. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:38Z: regenerated main image v2 using white-background plus actual LOGO-WT.png references. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:43Z: regenerated main image v3 with stricter LP logo instructions. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:45Z: selected QC-passed outputs; main image v3 accepted after v1/v2 logo QC failures. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:48Z: uploaded five selected ASI outputs to 商品主图. -->
<!-- LP2332_ASI_PROGRESS 2026-05-22T12:50Z: verified 白底图 count=1 and 商品主图 count=5 in raw record; LP2332 completed. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:39Z: created temp/LP2418_asi_recuYsACgfdACe and progress.json started; read asi-product-image-generator skill. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:40Z: read generate-white-background skill; preparing unified ASI instructions and lark preflight. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:42Z: read lark-base/lark-shared refs; completed lark-cli help, base help, table-list and field-list preflight. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:44Z: fetched raw record; 白底图 and 商品主图 empty; downloaded reference-01.jpeg. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:45Z: analyzed reference image, confirmed logo files, completed web search, wrote product AGENTS.md and generation plan. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:48Z: generated white-background image LP2418-white-background.png. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:50Z: uploaded LP2418-white-background.png to 白底图 field. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:51Z: completed web search for 40oz tumbler pouch ecommerce references; starting non-main ASI images. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:54Z: generated scene image LP2418-scene.png. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T12:57Z: generated selling-point image LP2418-selling-points.png. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:00Z: generated material/detail image LP2418-material-detail.png. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:03Z: generated SKU color chart LP2418-sku-colors.png; size image skipped due no reliable dimensions. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:06Z: generated main image last using white-background plus actual LOGO-WT.png as reference. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:10Z: selected outputs QC passed; main image accepted after logo QC; starting 商品主图 upload. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:13Z: uploaded five selected ASI outputs to 商品主图. -->
<!-- LP2418_ASI_PROGRESS 2026-05-22T13:15Z: verified 白底图 count=1 and 商品主图 count=5 in raw record; LP2418 completed. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:02Z: created temp/LP2508_asi_recuYsACgfoROP and progress.json started. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:04Z: read asi-product-image-generator and generate-white-background skills. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:06Z: completed lark-cli preflight; fetched field list and raw record. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:10Z: download attempt hit unsafe absolute output path; retrying relative output. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:11Z: downloaded reference image and confirmed LOGO-BK.png / LOGO-WT.png exist. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:15Z: analyzed reference image/record, completed web search, wrote product AGENTS.md generation plan. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:18Z: generated white-background image LP2508-white-background.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:20Z: white-background v1 failed QC; regenerating stricter structure prompt. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:24Z: uploaded white-background v2 to 白底图 field. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:29Z: generated scene image LP2508-scene.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:33Z: generated selling point image LP2508-selling-points.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:37Z: generated size image LP2508-size.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:41Z: generated material/detail image LP2508-material-detail.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:45Z: generated SKU color chart LP2508-sku-colors.png; non-main images complete. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:48Z: non-main QC passed; starting main image last with white-background plus LOGO-WT.png references only. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:52Z: generated main image last using white-background plus actual LOGO-WT.png reference. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T13:55Z: main image v1 failed logo QC; regenerating stricter with actual LOGO-WT.png. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T14:02Z: generated main image v3 with stricter exact LOGO-WT prompt. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T14:07Z: uploaded six selected ASI outputs to 商品主图. -->
<!-- LP2508_ASI_PROGRESS 2026-05-22T14:11Z: verified 白底图 count=1 and 商品主图 count=6 in raw record; LP2508 completed. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:33Z: created temp/LP2545_asi_recuYsACgfiggW and progress.json started. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:35Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:37Z: completed lark-cli preflight, field-list, and raw record fetch. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:39Z: downloaded reference image and confirmed LOGO-BK.png / LOGO-WT.png files exist. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:42Z: analyzed reference image, completed web search, wrote product AGENTS.md and generation plan. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:47Z: generated white-background image LP2545-white-background.png after creating missing outputs directory. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:49Z: white-background v1 failed QC; regenerating with stricter cooler-bag structure prompt. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:54Z: uploaded white-background v2 to 白底图 field. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T13:58Z: generated scene image LP2545-scene.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:02Z: generated selling point image LP2545-selling-points.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:06Z: generated size image LP2545-size.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:10Z: generated material/detail image LP2545-material-detail.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:14Z: generated SKU color chart LP2545-sku-colors.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:16Z: non-main QC passed; starting main image last with white-background plus LOGO-WT.png references only. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:20Z: generated main image last using white-background plus actual LOGO-WT.png reference. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:22Z: main image v1 failed logo QC (YOUR LOGO); regenerating stricter with actual LOGO-WT.png. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:26Z: generated main image v2 with stricter official LOGO-WT reference. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:29Z: selected outputs QC passed; main v2 accepted after v1 logo QC failure. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:34Z: uploaded six selected ASI outputs to 商品主图. -->
<!-- LP2545_ASI_PROGRESS 2026-05-22T14:37Z: verified 白底图 and 商品主图 uploads in raw record; LP2545 completed. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:08Z: created temp/LP2710_asi_recuYsACgfrKin and progress.json started. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:10Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:13Z: completed lark-cli preflight, field-list, table-list, and raw record fetch. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:16Z: downloaded reference image and confirmed LOGO-BK.png / LOGO-WT.png exist. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:20Z: analyzed reference image, completed web search, wrote product AGENTS.md and generation plan. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:24Z: generated white-background image LP2710-white-background.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:27Z: uploaded LP2710-white-background.png to 白底图 field. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:32Z: generated scene image LP2710-scene.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:36Z: generated selling point image LP2710-selling-points.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:40Z: generated size image LP2710-size.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:44Z: generated material/detail image LP2710-material-detail.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:48Z: generated SKU color chart LP2710-sku-colors.png. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:51Z: non-main QC passed; starting main image last with white-background plus LOGO-WT.png references only. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:55Z: generated main image last using white-background plus actual LOGO-WT.png reference. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T14:57Z: main image v1 failed logo QC; regenerating stricter with actual LOGO-WT.png reference. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T15:01Z: generated main image v2 with stricter LOGO-WT reference. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T15:08Z: uploaded six selected ASI outputs to 商品主图. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T15:11Z: verified 白底图 count=1 and 商品主图 count=6 in raw record; LP2710 completed. -->

<!-- LP2710_ASI_PROGRESS 2026-05-22T15:13Z: final report ready; web reference search completed. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:40Z: created temp/LP3309_asi_recuYsACVIUmMp and progress.json started. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:43Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:45Z: completed lark-cli preflight; fetched field list and raw record; 白底图 and 商品主图 are empty; one reference image found. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:49Z: downloaded reference image, confirmed logo files, analyzed source, completed web search, wrote product AGENTS.md and generation plan. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:52Z: generated white-background image LP3309-white-background.png. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:54Z: uploaded LP3309-white-background.png to 白底图 field. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:56Z: confirmed white-background upload command completed and progress updated after cwd-relative progress write issue. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T14:59Z: generated scene image LP3309-scene.png. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:03Z: scene v1 failed/borderline QC; regenerated scene v2 without text and clearer product. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:06Z: generated selling point image LP3309-selling-points.png. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:09Z: generated size image LP3309-size.png using confirmed 3.03 x 3.03 x 8.9 in dimensions. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:12Z: generated material/detail image LP3309-material-detail.png. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:16Z: generated SKU color chart LP3309-sku-colors.png. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:18Z: non-main QC passed; starting main image last using white-background plus actual LOGO-BK.png references only. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:21Z: generated main image last using white-background plus actual LOGO-BK.png reference. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:26Z: main v1 failed logo QC (PUREPEAK); regenerated main v2 with stricter exact LOGO-BK instructions. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:31Z: main v2 failed logo QC; regenerated main v3 using dark gray SKU and actual LOGO-WT.png reference. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:36Z: main v3 logo closer but product structure failed QC; regenerated main v4 with stricter collapsible silicone structure prompt. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:41Z: main v4 failed logo/structure QC; regenerated main v5 with white-background + actual LOGO-BK.png + one original reference solely for structure after repeated structure failures. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:45Z: selected six ASI outputs; main v5 accepted as best QC after v1-v4 failures and actual logo file was passed. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:49Z: uploaded six selected ASI outputs to 商品主图. -->
<!-- LP3309_ASI_PROGRESS 2026-05-22T15:52Z: verified 白底图 count=1 and 商品主图 count=6 in raw record; LP3309 completed. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:29Z: created temp/LP6992_asi_recv6hAgxDqr2r and progress.json started. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:31Z: read asi-product-image-generator, generate-white-background, and unified ASI instructions. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:33Z: completed lark-cli preflight, field-list, table-list, and raw record fetch. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:35Z: downloaded reference image reference-01.jpeg; 白底图 and 商品主图 confirmed empty. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:38Z: analyzed reference image, completed web search, confirmed logo files, wrote product AGENTS.md and generation plan. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:41Z: generated white-background image LP6992-white-background.png; basic QC passed. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:46Z: created missing uploads directory and uploaded LP6992-white-background.png to 白底图 field. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:48Z: completed web search for men quarter-zip athletic shirt ecommerce reference concepts. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:51Z: generated scene image LP6992-scene.png; basic QC passed. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:54Z: generated selling point image LP6992-selling-points.png; basic QC passed. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T16:57Z: generated material/detail image LP6992-material-detail.png; basic QC passed. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:00Z: generated SKU color chart LP6992-sku-colors.png; size image skipped due no reliable dimensions. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:04Z: generated main image last using white-background plus actual LOGO-WT.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:06Z: main image v1 failed logo QC (YOUR LOGO/incorrect logo); regenerating stricter with actual LOGO-WT.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:09Z: generated main image v2 with stricter LOGO-WT reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:11Z: main image v2 failed logo QC; regenerating main v3 with supported khaki SKU and actual LOGO-BK.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:14Z: generated main image v3 with actual LOGO-BK.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:16Z: main image v3 failed logo QC; regenerating main v4 with explicit CLP/infinity + YOUR LOGO instructions and actual LOGO-BK.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:19Z: generated main image v4 with actual LOGO-BK.png reference. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:21Z: main image v4 passed logo QC after v1-v3 failures; selected for upload. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:24Z: uploaded five selected ASI outputs to 商品主图. -->
<!-- LP6992_ASI_PROGRESS 2026-05-22T17:27Z: verified 白底图 count=1 and 商品主图 count=5 in raw record; LP6992 completed. -->
