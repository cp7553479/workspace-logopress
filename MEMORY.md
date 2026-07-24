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

## Promoted From Short-Term Memory (2026-07-24)

<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:29:32 -->
- 21:05 CST compaction checkpoint: LP0913 and LP0910 subsequently completed full generation, verified Base backfill, and image delivery to Vincent. The verified-complete count reached 44. LP0910 delivered 18 images; SKU color/size correspondence should still receive manual review before release.; LP0943 and LP0944 were dispatched as the two recovery flows after LP0910. LP0943 previously reached only clean-reference and white-background stages; scene output changed the product shape and was rejected.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:29-32]
<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:13:16 -->
- Later durable updates: LP2147 (`record_id=recuYsA1RQ9xQZ`) completed generation, visual verification, and Base backfill: one cleaned logo-free reference, ten color-variant white-background images, and four main images (SKU chart, size diagram, festival lifestyle image, and final hero image with LOGO-BK). Rejected candidates were not uploaded. Its occupation lock was released; delivery notification remains pending.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:3:6 -->
- 2026-07-19 — ASI product-image queue checkpoint: Batch objective remains: process only LogoPress ERP `商品表` records where product-main-image is empty and reference-image is present. Scheduler must lock one explicitly selected record (product number, record ID, record version, reference attachment token), never let a subtask choose/filter a SKU, and allow at most two different products concurrently. Re-read immediately before every remote write; any version/attachment mismatch pauses without overwrite.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:3-6]
<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:7:9 -->
- 2026-07-19 — ASI product-image queue checkpoint: LP0951 (record `recuYsA1RQaSlf`): clean reference and white-background backfill are complete. Two scene candidates were rejected (wrong product shape; unexplained mark). A Codex fallback scene generation is in progress; no main image uploaded yet. After an approved scene, complete selling point and final first image, with re-read protection. Status: `.temp/LP0951_asi_recuYsA1RQaSlf/STATUS.md`; lock remains active.; Latest scheduler capacity: LP0947 and LP0951 are the active flows; one parallel slot was reported idle before this checkpoint.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:7-9]
<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:17:18 -->
- Later durable updates: At Vincent's request, the global default and `logopress` Heartbeat prompt were changed to English: "Continue proactively completing the tasks in HEARTBEAT.md. If the tasks in HEARTBEAT.md no longer need attention, clear HEARTBEAT.md." Configuration validation passed and the gateway was restarted successfully.; Vincent requested that all future formal subagent tasks use Claude. Claude may be slow to produce output, so do not impose a timeout; wait for its actual completion.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:17-18]
<!-- openclaw-memory-promotion:memory:memory/2026-07-19.md:22:25 -->
- Dispatch-method correction and current queue state (evening): The preceding Claude-only ACP instruction was superseded after a no-output greeting test and a 90-second wait-layer disconnect. Codex ACP also failed with `ACP_TURN_FAILED`. Formal ASI subtasks must therefore use OpenClaw `sessions_spawn` with `runtime: "subagent"` (not ACP/Claude) until the ACP runtime is repaired.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-19.md:22-25]
<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:27:27 -->
- 00:37 CST — LP0984 continuation: LP0984 (`recuYsA4H00tsL`) passed a two-read continuation preflight and has a fresh exclusive lock. Its verified baseline is clean reference `ZTl4b0lD7oibgGx8ABMcMzrLntb`, white background `GQn4bl7PpoDKc7xsBaocQTD4nZc`, and existing accepted hero `BCx2bWvzMoCmUSxai8pcHxoLnxe`; generate only a scene and selling-point image, preserving current attachments. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-20.md:27-27]
<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:19:19 -->
- 00:23 CST — Image acceptance preference: User confirmed that a flash/star-shaped mark in the lower-right corner of a generated image is acceptable and must not by itself cause rejection. This is an acceptance-only rule: never mention, request, or otherwise put the mark into image-generation prompts. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-20.md:19-19]
<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:23:23 -->
- 00:25 CST — LP1035 completed: LP1035 (`recuYsA1RQjQ03`) was independently verified after worker completion and its exclusive lock released. The stable cloud record has one clean reference (`BKgjbd0T7ocAldxIxbKcVr1Jn3b`), three white-background images, and four main images: lifestyle, SKU, dimensions, and final `YOUR LOGO` hero. All returned tokens matched the remote double read; the main scheduler must deliver the four verified main images to Vincent. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-20.md:23-23]
<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:11:14 -->
- 00:23 CST — Durable ASI queue state: The active image-generation queue must maintain a maximum of two distinct, explicitly specified products. Before every dispatch, the scheduler must re-filter the Base candidates and record product number, record ID, current version, reference attachment token, then create one exclusive per-product lock. Workers may process only their assigned product and must re-read immediately before every Base write; a lock is released only after the worker is confirmed ended and the main scheduler re-verifies cloud state.; Formal worker dispatch uses OpenClaw `sessions_spawn` with `runtime: "subagent"`; do... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-20.md:11-14]
