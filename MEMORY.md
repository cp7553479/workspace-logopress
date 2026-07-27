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

## Promoted From Short-Term Memory (2026-07-25)

<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:5:7 -->
- 00:01 CST — ASI queue supervision: LP0985 final black-and-white text-only `YOUR LOGO` hero was independently accepted and delivered before midnight; its lock is released.; Current cloud-side filter (empty `商品主图`, non-empty `参考图片`) selected LP1035 (`recuYsA1RQjQ03`) as a fresh candidate after legacy/conflict-prone items. Two matching reads fixed reference `LS7cbKGdBogXIMx3fIpcWe39nWf`, no white-background image, and no main images.... [score=0.818 recalls=0 avg=0.620 source=memory/2026-07-20.md:5-7]
<!-- openclaw-memory-promotion:memory:memory/2026-07-20.md:15:15 -->
- 00:23 CST — Durable ASI queue state: Keep `HEARTBEAT.md` as the operational source for the continuous scheduler rules. After each worker ends, re-read and verify its specific record, release its occupation, select at most one next candidate to fill a free slot, and have the main scheduler deliver approved images. Clear HEARTBEAT.md only once the entire queue is complete. [score=0.818 recalls=0 avg=0.620 source=memory/2026-07-20.md:15-15]

## Promoted From Short-Term Memory (2026-07-26)

<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:5:5 -->
- 2026-07-23 01:37 CST checkpoint — LP1308 (`recuYsA4H0hGTx`) made no Base or attachment changes after generation services failed: Oracle ChatGPT rejects `--profile`, Gemini quota is exhausted, and Codex returned `fetch failed`/no saved file. Original reference `UIccbuIp7ogj8JxqbpBchMTlnAf` remains; white-background and main-image fields remain empty. Evidence: `.temp/LP1308_asi_recuYsA4H0hGTx/generation_evidence.md`. Lock released as blocked-generation-services; do not retry until service recovery is confirmed. [score=0.833 recalls=0 avg=0.620 source=memory/2026-07-22.md:5-5]
<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:12:12 -->
- 2026-07-22 11:00 CST checkpoint — ASI queue remains active and its supervisor heartbeat is healthy. LP1112 (`recuYsA4H0pSo6`) is complete for its current required set: clean and white assets plus Oracle ChatGPT selling-point image token `K9pWbxRE9oamrDxbKGhcXp8Onhc`; SHA/readback verified and duplicates removed. LP2188 has clean, white, and lifestyle/core images verified in Base; its selling-point image and remaining assets are still pending.... [score=0.833 recalls=0 avg=0.620 source=memory/2026-07-22.md:12-12]
<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:14:14 -->
- The ASI queue has numerous partial/checkpointed products rather than being empty. Priority tracking includes LP1264 (full set generated, pending upload/verification); LP1293 and LP4402 (generated sets pending upload/verification); LP1106, LP0986, LP1079, LP1069, LP1335, LP1072, LP1411, LP1290, LP1292, LP1455, LP2202, and LP2188 (remaining assets pending). LP1082 and LP2047 require a `LOGO-BK.png` reference before hero generation. LP2191, LP2519, LP0987, LP1099, and LP2203 have preserved all-path failure evidence and need an explicit retry/abort decision.... [score=0.804 recalls=0 avg=0.620 source=memory/2026-07-22.md:14-14]
<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:3:3 -->
- 2026-07-23 LP1156 (`recuYsA4H0HgFK`) checkpoint independently accepted and reread: `参考图片` is exactly one clean no-logo image `DAQTbHjadoGbxNxexXOc6wm9nFf`, `白底图` is exactly one black variant `G3Cbbo98Soib2jxJKcycztcgnSf`, and `商品主图` remains empty. Both local 1254×1254 PNGs were visually reviewed and match the real black 3-in-1 insulated can holder with its detached opener lid; no prohibited marks were present.... [score=0.804 recalls=0 avg=0.620 source=memory/2026-07-22.md:3-3]
<!-- openclaw-memory-promotion:memory:memory/2026-07-21.md:3:5 -->
- LP1081 (`recuYsA4H03pXR`) completed and parent-verified: clean reference, white-background image, lifestyle image, and LogoPress hero image are present in Feishu Base. The attachment tokens and names match `.temp/LP1081_asi_recuYsA4H03pXR/manifest.md`; visual inspection accepted the two main images. - ASI supervisor follow-up: LP1395 (`recuYsA4H0PX5M`) was independently verified complete (one clean reference, one white-background image, four product-main images) and all except its Hero were delivered; the Hero send failed with a Feishu OAuth transport EOF and must be re-sent before claiming full delivery.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-21.md:3-5]

## Promoted From Short-Term Memory (2026-07-27)

<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:7:10 -->
- ASI queue — 2026-07-23 00:15 CST: LP0991 (`recuYsA4H0tXBj`) completed its verified product-main asset: token `GRTVb44AcorOiYxPvJJc8BScnad`, SHA-256 `b776bae1d6b68064b073fe2a8954e25873da6f7ec5a972e2217fd448899bda67`, delivered successfully and lock released. Its freed slot was double-read, baseline-locked, and assigned to LP1448 (`recuYsA4H0vLjh`); LP1304 remains the other active locked worker.; LP0992 produced a delayed completion after its initial no-artifact audit: the controller independently read back lifestyle `MXLSbpxPyo2swvxClUmcoEuXnfh` and SKU `IIREbtr2SomRN4xiabIcwq2Pnta`, then delivered both.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:7-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:11:14 -->
- ASI queue — 2026-07-23 00:15 CST: LP1449 (`recuYsA4H0JE2I`) completed: clean `IDKLbG2kZocysNxtiUPcAIoRnEf`, two white SKU images `VfwBbP68CojucOx4UeRcObLCndh` and `GYV0br8K9om1IYxFyTVcNMc4nPd`, hero `MknJbsQXDoVBIgxm3hlcztWvnPb` independently read back and individually delivered; lock released.; LP1649 (`recuYsA4H0cium`) completed: clean `EKe8bjcz9oGJIQxIEy9c0bqTnke`, white `ZbKGb7hIEoldD5xHq90ctT94nwe`, hero `R2mmbSu3ZoHDs8xhE2LcF1Znnkf` independently read back and individually delivered; lock released.; LP1391 (`recuYsA4H0mIdg`) was safely released: TLS timeouts prevented confirmation after an attempted clean-reference... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:11-14]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:3:6 -->
- ASI queue — 2026-07-23 00:15 CST: LP0931 (`recuYsAdUpcsBa`) completed: Base readback confirmed the clean reference, five white-background attachments, and six product-main attachments; all twelve verified local assets were individually delivered to the owner and the active lock was released with receipt evidence in `.temp/LP0931_asi_recuYsAdUpcsBa/uploads/`.; LP1000 (`recuYsA4H0dPJA`) had already completed its independent readback and individual delivery shortly before this audit; its released lock records the seven delivery receipts.; New protected double-read baselines were locked and workers dispatched only for LP0992... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:3-6]
