# MEMORY.md - Long-Term Memory

## Workspace
- Agent: global-trading-product (logopress workspace)
- Host: Vincent's MacBook Air (macOS, arm64)
- Git auto-syncs with macmini remote
- Skills: add-product, quotation, inquiry, new-pi, print-pi, asi-product-image-generator, asi-xid-sync, generate-white-background, cron-heartbeat-watcher, and more

## Key Facts
- Workspace uses Feishu (飞书) multi-dimensional tables for product management
- Product table (商品表) and PI table are core data sources
- ASI product image generation pipeline exists for e-commerce photos
- Quotation and PI (Proforma Invoice) workflows are established

## Lessons Learned
- (none yet)

## People
- Vincent: workspace owner

## Notes
- Initialized memory infrastructure on 2026-07-14

## Promoted From Short-Term Memory (2026-07-21)

<!-- openclaw-memory-promotion:memory:memory/2026-07-16.md:20:23 -->
- 持久化更新（2026-07-16 10:18 CST）: LP0744（record_id `recuRcKdQKhC90`）已完成无 Logo 图、白底图、场景图、卖点图、尺寸图、细节图的回写及下载/反向下载/SHA-256 核验；细节图文件为 `LP0744_detail_four_tab_recovery.png`，真实四卡位瓶托结构验收通过。; LP0744 LOGO-BK Hero 图首次生成于约 08:56 CST 失败，错误将真实四卡位瓶托重绘为六卡位；未产生上传或回写副作用，按更新后的 10 分钟冷却规则，现已可使用已认证 Oracle profile 重试。; LP0744 Hero 图通过后仍需完成全量下载核验，并将全部生成图片逐张发送至飞书；商品完成后排除 LP0744 与已完成商品，实时查询并继续处理剩余符合条件商品，直到队列清空。; 当前已完成全流程闭环商品：LP0738、LP0739、LP0740、LP0741、LP0742、LP0743；LP0743最终为参考图 1 张、白底图 1 张、主图 6 张，共 8 个附件，均已逐张发送。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-16.md:20-23]
<!-- openclaw-memory-promotion:memory:memory/2026-07-16.md:13:16 -->
- 持久化更新（2026-07-16 09:27 CST）: 用户已将生图异常失败后的冷却期从 1 小时更新为 10 分钟；`skills/asi-product-image-generator/SKILL.md` 已完成更新并清除旧表述，后续 LP0744 细节图失败恢复按 10 分钟执行。; `HEARTBEAT.md` 已补充完整任务详情，并保持具体商品状态、失败时间和重试信息记录在 `.temp/asi-product-queue/task-progress.md`；`git diff --check` 已通过。; 当前任务仍停在 LP0744：细节图最近一次失败后应于约 08:42 CST 起恢复，恢复时使用已认证 Oracle profile；细节图通过后生成 LOGO-BK Hero 图，完成全量核验和逐张飞书发送，再查询下一个符合条件商品。; 需继续遵守：每次执行、切换商品、派生 subagent、商品完成及失败恢复前复述精简任务详情；每次至少命中两个候选时并行派生两个独立 subagent；每个 subagent 只处理一个指定商品并从断点继续，不重复生成。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-16.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-07-16.md:3:6 -->
- ASI 商品套图任务（截至 2026-07-16 08:37 CST）: 核心流程：从 LogoPress ERP 主 Base「商品表」筛选“商品主图为空且参考图片有图”的商品；每次最多并行处理 2 个商品，每个商品由独立 subagent 处理且不得继续派生商品 subagent。完整交付包括：无 Logo 参考图、白底图，以及按商品属性生成的 7 张主图；所有回写都必须下载/回读核验，完成商品后逐张发送到飞书。; 已完成全流程并验收、回写和逐张发送：LP0738、LP0739、LP0740、LP0741、LP0742、LP0743。LP0743最终为参考图 1 张、白底图 1 张、主图 6 张，共 8 个附件；所有附件已逐字节核验。; 当前仅处理 LP0744（record_id `recuRcKdQKhC90`）。已验收并回写：无 Logo 图、白底图、场景图、卖点图、尺寸图；当前 Base 保持 5 张合格附件。工作目录：`.temp/asi-product-queue/LP0744_recuRcKdQKhC90/`。; LP0744 细节图最近一次重试（约 08:32 后）仍把真实四卡位瓶托错误重绘为六卡位，已拒收且无 Base 副作用；按“生图异常失败后等待 1 小时”规则，新的冷却窗口至 09:35 CST。恢复时必须使用已认证 Oracle profile 重试，避免此前 `second` profile 未登录问题。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-16.md:3-6]
<!-- openclaw-memory-promotion:memory:memory/2026-07-16.md:7:9 -->
- ASI 商品套图任务（截至 2026-07-16 08:37 CST）: LP0744 细节图验收通过后，继续生成 LOGO-BK Hero 图；随后做全量下载核验并逐张发送 LP0744 全部生成图片至飞书，再实时查询下一个符合条件商品。查询时排除 LP0744 和全部已完成商品，避免队列竞态重复命中。; 生图优先级：Oracle 浏览器模式 ChatGPT 优先，Gemini 仅负责无 Logo/白底（额度不足时转 ChatGPT），其余套图用 ChatGPT；两者不可用时 Codex 兜底。正确 Oracle 参数：`--engine browser --manual-login --profile [second/default] --model gpt-5.6-terra --browser-model-strategy select --browser-attachments always`。每次执行、切换商品、派生 subagent、商品完成和失败恢复前需复述精简任务详情；subagent 执行前需阅读 skill、进度和交接信息并从断点继续。; 关键文件：`skills/asi-product-image-generator/SKILL.md`（冷却规则）、`.temp/asi-product-queue/task-progress.md`（商品状态与失败信息）、`HEARTBEAT.md`（仅动态动作）。飞书... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-16.md:7-9]
<!-- openclaw-memory-promotion:memory:memory/2026-07-16.md:24:24 -->
- 持久化更新（2026-07-16 10:18 CST）: 任务规则仍有效：每次执行、切换商品、派生 subagent、商品完成和失败恢复前复述精简任务详情；命中至少两个候选时并行派生两个独立 subagent，每个仅处理一个指定商品且不得继续派生商品 subagent；subagent执行前阅读 skill、进度和交接信息并从断点继续。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-16.md:24-24]

## Promoted From Short-Term Memory (2026-07-22)

<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:7:8 -->
- Oracle/ChatGPT browser mode has recurring `ECONNREFUSED 127.0.0.1:<port>`, manual-login-session timeout, and no-output failures. Treat this as a browser-session availability issue, preserve validated work, and resume from the checkpoint after confirming the second profile is logged in. - Operational rules and per-product checkpoints live in `HEARTBEAT.md`, `task-progress.md`, and each product's `.temp/LPxxxx_asi_<record_id>/` handoff files. HEARTBEAT includes a five-minute recovery audit covering worker state, Base state, cooling/retry timing, and exclusive write ownership. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:7-8]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:12:15 -->
- 2026-07-17 11:54 CST — corrected pipeline checkpoint: The older entries above are superseded where they conflict with this checkpoint: the Oracle `second` browser profile was deleted. All future Oracle work must use only the `default` profile; do not recreate or use `second`.; Fully closed and slot-released products: LP0747 and LP0749.; LP0750 remains an active slot, blocked at the clean-logo-reference step. Oracle `default` did not detect a valid ChatGPT login session; Gemini subsequently terminated when its WebSocket closed. No output was generated, uploaded, or written to Base in this retry.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:16:16 -->
- 2026-07-17 11:54 CST — corrected pipeline checkpoint: Therefore, do not dispatch LP0752 or later yet: LP0750 and LP0751 still occupy the two unfinished-product slots. Continue the five-minute audit and recover stalled work without duplicate workers or concurrent attachment writes. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:16-16]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:27:30 -->
- 2026-07-17 20:13 CST — latest ASI pipeline and delivery checkpoint: Supersedes earlier pipeline status where inconsistent. The active global objective remains: continuously process LogoPress ERP `商品表` entries where 商品主图 is empty and 参考图片 is present; one worker per product, at most two concurrent products, complete the ASI asset set, validate, write back and read back, then deliver accepted images to Vincent.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:27-30]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:20:23 -->
- 2026-07-17 13:13 CST — current pipeline checkpoint: This checkpoint supersedes conflicting earlier entries. Fully closed and slot-released products are LP0747, LP0749, LP0751, and LP0750. LP0750’s last two assets—the two-color SKU image and final Hero—were accepted, written to Base, read back, reverse-SHA verified, and delivered; its evidence is in `.temp/LP0750_asi_recuRcKFugmc2D/handoff.md`.; LP0752 is the sole currently occupied slot. Its clean reference, three color white-background images, scene image, and selling-point image were accepted, written to Base, read back, SHA verified, and delivered.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:20-23]
<!-- openclaw-memory-promotion:memory:memory/2026-07-17.md:3:6 -->
- Ongoing ASI product-image pipeline: keep exactly two active, unfinished product slots. When one closes its full loop, immediately query the LogoPress ERP 商品表 for the next eligible product (empty main image and a reference image; exclude completed/in-progress) and assign one dedicated worker. - Each product requires generation, acceptance review, Feishu Base write-back, read-back/SHA verification, and individual image delivery. Never skip those stages; only one worker may write a product's attachments. - Image fidelity is paramount: do not invent, alter, redraw, or omit real product structure, quantities, labels, or details.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-17.md:3-6]
