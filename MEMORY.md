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

## Promoted From Short-Term Memory (2026-07-19)

<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:32:34 -->
- Later status update: The plugin/gateway issue was manually bypassed by starting dedicated Codex ACP execution lanes for the two already-approved items only. LP0735's lane exited abnormally immediately, with no generation, upload, or Feishu Base write-back; its handoff and six existing local output files remain intact.; LP0737's dedicated execution lane is still running. On completion, verify every upload and Base field write-back, then update the queue progress/heartbeat files.... [score=0.815 recalls=0 avg=0.620 source=memory/2026-07-15.md:32-34]
<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:26:28 -->
- ASI dynamic product-image queue: Next action after the OpenClaw gateway/ACP service is restarted: re-dispatch LP0735 finalization and LP0737 execution; do not open more candidate products.; Diagnosed configuration-level cause: the `acpx` and `codex` plugins are disabled or absent from the OpenClaw allowlist, preventing ACP sessions from starting. Recovery requires correcting that configuration and restarting the gateway; then resume only the two existing lanes.; Queue execution constraints: one candidate at a time; ChatGPT is preferred for generation; Gemini is only for logo cleanup and white-background images; logo cleanup must... [score=0.815 recalls=0 avg=0.620 source=memory/2026-07-15.md:26-28]
<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:5:8 -->
- ASI dynamic product-image queue: WG1736 is fully completed and uploaded to Feishu Base. Its approved cleaned reference token is `HJ5lbC4jUom82nxETSvcUjDpn4t`; white-background token is `VRuqbQFS2oD4BtxcwMhcxwhinlb`; four main-image tokens are `Lspdbi5P3o4pu8xBPAqcSLEUnIh`, `M24rbKsakonxbfxcRP0cHrWan5b`, `Jeg8bLRFbo85mCxjyfQcEpezneg`, and `EAzIbf23Aoii0ZxCuQAcwuf7nSd`.; LP0737 was prepared as the one permitted replacement candidate while LP0735 remains open: Base record `recuRcJVJ1VSel`, reference attachment token `HnsobZFWDoBgvbxINw9cgrPin2d`.... [score=0.815 recalls=0 avg=0.620 source=memory/2026-07-15.md:5-8]

## Promoted From Short-Term Memory (2026-07-20)

<!-- openclaw-memory-promotion:memory:memory/2026-07-14.md:12:15 -->
- ASI product-image pipeline (later today): The workflow runs a dynamic two-lane queue against the Feishu Base product table: select only records with `参考图片` populated and `商品主图` empty; after parent verification and delivery, live-query again to refill the freed lane. Keep at most two products active.; Completed, parent-verified, and delivered earlier in this batch: LP0641, LP0643, LP0644, LP0645, LP0647, LP0717, LP0718, LP0719, LP0720, LP0723, LP0726, LP0727, LP0728, LP0730, WG1736, and WG1207.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-14.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-07-14.md:16:19 -->
- ASI product-image pipeline (later today): Refill selected LP0734 / WG1238 (`recuRcH16qroSw`, Oracle-first) and LP0735 / WG1205 (`recuRcH4RCsr1X`, Codex-first). Handoffs are under `.temp/asi-dynamic-queue-20260713/`.; LP0734 passed independent review: reference=1, white background=1, main images=4, with original reference marks removed. Its six files were sent in Feishu: clean/no-logo, white background, hero, lifestyle, detail, dimension.; LP0735 required a recovery because its images existed but `商品主图` had not been written to Base.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-14.md:16-19]
<!-- openclaw-memory-promotion:memory:memory/2026-07-14.md:4:7 -->
- Heartbeat 13:51: Workspace initialized: no prior MEMORY.md, HEARTBEAT.md, or daily notes existed; Memory directory was empty; Found ~8MB of old .temp_*.json files (June 29) and 705MB in .temp/ image dirs (June 23-26); Workspace total: 1.3GB [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-14.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-07-14.md:8:9 -->
- Heartbeat 13:51: Git: last sync at 12:18 today, auto-syncing from macmini; Created heartbeat-state.json, MEMORY.md, this daily note [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-14.md:8-9]
<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:15:17 -->
- Later status update: The plugin/gateway issue was manually bypassed by starting dedicated Codex ACP execution lanes for the two already-approved items only. LP0735's lane exited abnormally immediately, with no generation, upload, or Feishu Base write-back; its handoff and six existing local output files remain intact.; LP0737's dedicated execution lane is still running. On completion, verify every upload and Base field write-back, then update the queue progress/heartbeat files.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-15.md:15-17]
<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:9:11 -->
- ASI dynamic product-image queue: Next action after the OpenClaw gateway/ACP service is restarted: re-dispatch LP0735 finalization and LP0737 execution; do not open more candidate products.; Diagnosed configuration-level cause: the `acpx` and `codex` plugins are disabled or absent from the OpenClaw allowlist, preventing ACP sessions from starting. Recovery requires correcting that configuration and restarting the gateway; then resume only the two existing lanes.; Queue execution constraints: one candidate at a time; ChatGPT is preferred for generation; Gemini is only for logo cleanup and white-background images; logo cleanup must... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-15.md:9-11]
<!-- openclaw-memory-promotion:memory:memory/2026-07-15.md:22:25 -->
- ASI dynamic product-image queue: WG1736 is fully completed and uploaded to Feishu Base. Its approved cleaned reference token is `HJ5lbC4jUom82nxETSvcUjDpn4t`; white-background token is `VRuqbQFS2oD4BtxcwMhcxwhinlb`; four main-image tokens are `Lspdbi5P3o4pu8xBPAqcSLEUnIh`, `M24rbKsakonxbfxcRP0cHrWan5b`, `Jeg8bLRFbo85mCxjyfQcEpezneg`, and `EAzIbf23Aoii0ZxCuQAcwuf7nSd`.; LP0737 was prepared as the one permitted replacement candidate while LP0735 remains open: Base record `recuRcJVJ1VSel`, reference attachment token `HnsobZFWDoBgvbxINw9cgrPin2d`.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-15.md:22-25]
