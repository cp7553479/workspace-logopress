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

## Promoted From Short-Term Memory (2026-07-27)

<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:7:10 -->
- ASI queue — 2026-07-23 00:15 CST: LP0991 (`recuYsA4H0tXBj`) completed its verified product-main asset: token `GRTVb44AcorOiYxPvJJc8BScnad`, SHA-256 `b776bae1d6b68064b073fe2a8954e25873da6f7ec5a972e2217fd448899bda67`, delivered successfully and lock released. Its freed slot was double-read, baseline-locked, and assigned to LP1448 (`recuYsA4H0vLjh`); LP1304 remains the other active locked worker.; LP0992 produced a delayed completion after its initial no-artifact audit: the controller independently read back lifestyle `MXLSbpxPyo2swvxClUmcoEuXnfh` and SKU `IIREbtr2SomRN4xiabIcwq2Pnta`, then delivered both.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:7-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:11:14 -->
- ASI queue — 2026-07-23 00:15 CST: LP1449 (`recuYsA4H0JE2I`) completed: clean `IDKLbG2kZocysNxtiUPcAIoRnEf`, two white SKU images `VfwBbP68CojucOx4UeRcObLCndh` and `GYV0br8K9om1IYxFyTVcNMc4nPd`, hero `MknJbsQXDoVBIgxm3hlcztWvnPb` independently read back and individually delivered; lock released.; LP1649 (`recuYsA4H0cium`) completed: clean `EKe8bjcz9oGJIQxIEy9c0bqTnke`, white `ZbKGb7hIEoldD5xHq90ctT94nwe`, hero `R2mmbSu3ZoHDs8xhE2LcF1Znnkf` independently read back and individually delivered; lock released.; LP1391 (`recuYsA4H0mIdg`) was safely released: TLS timeouts prevented confirmation after an attempted clean-reference... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:11-14]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:3:6 -->
- ASI queue — 2026-07-23 00:15 CST: LP0931 (`recuYsAdUpcsBa`) completed: Base readback confirmed the clean reference, five white-background attachments, and six product-main attachments; all twelve verified local assets were individually delivered to the owner and the active lock was released with receipt evidence in `.temp/LP0931_asi_recuYsAdUpcsBa/uploads/`.; LP1000 (`recuYsA4H0dPJA`) had already completed its independent readback and individual delivery shortly before this audit; its released lock records the seven delivery receipts.; New protected double-read baselines were locked and workers dispatched only for LP0992... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:3-6]

## Promoted From Short-Term Memory (2026-07-28)

<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:9:10 -->
- LP1294 (`recuYsA4H0k2z6`) ASI image set verified complete: clean reference token `Ax2FbmLY3oMe24xbPc9cvoqwnhf` unchanged; white-background token `WEmvbntIVo8FXzxo3xCcwqxnnPh`; four main-image tokens `VZkMbQ3CcoPJEWxgLHrcvfTdn7g`, `OglObVouaoqbGYxsnJMceO9cnWc`, `WYfXbEQzpo7iHdxUatBcGyT7nzf`, `GkH8bpOBLoHSQpxXkfncB48Bnib`. All assets are square PNGs and the existing delivery log records their Feishu sends.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-22.md:9-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:7:7 -->
- LP1450 (`recuYsA4H0ElRy`) checkpoint: controller independently visually accepted and readback verified reference `ZvGCbYaCtoYRNMxfFqNcRvSonhQ`, white `Ka8XbW2GkoxKz7xLaZ2c54OEnBf`, and main `RmSzb6tThoJNrsxnyPfcTwSnn0c`. No LP1450 worker was active; its exclusive lock was moved to released. Delivery is pending; do not regenerate or write Base. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-22.md:7-7]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:18:19 -->
- LP6587 Paztora PI — 2026-07-23 03:28 CST: Paztora confirmed final terms for a PI: 1,000 brown LP6587 Minimalist Front Pocket PU Leather Card Holder Slim Wallets, isotype-only deboss in matching material color (no “EVER” wordmark), express shipping to 14850 SW 38TH LN, Miami FL 33185, ATTN: PAZTORA; delivery requested by July 31 despite normal lead time not meeting it. Total is USD 650 inclusive of all fees: USD 0.52 × 1,000 = USD 520, setup USD 50, express shipping USD 80. Inquiry: `recvq1b8pAYIJj`; client artwork: `EVER_logo vertical CMYK Silver.ai`.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:18-19]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:23:24 -->
- IdeaStage inquiry 322909 — 2026-07-23 08:14 CST: New inquiry `recvq8fxbNXniZ` was created for IdeaStage Promotions, order ID 322909: LP0402 Quick Dry Sand-Free Turkish Beach Towel, 100 units, blue, custom full-color one-color imprint. It is a firm August 10, 2026 due date; provide a quote even if the date cannot be met. Shipping ZIP is 07458.; Still needed before a complete quote: full shipping address, named contact details, and logo/artwork (plus item template/artwork template if one is available). IdeaStage contacts on record: 1-866-890-5096 / 480-588-4140; 21020 N 8TH WAY STE 1, Phoenix, AZ 85024; ASI 229705, Sage 30350. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:23-24]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:28:28 -->
- IdeaStage quote update — 2026-07-23 11:41 CST: Generated and sent `2026-07-23-LP0402-100.xlsx` for IdeaStage Promotions order 322909. Confirmed quote inputs are USD 4.17 per LP0402 towel for 100 units plus a USD 50 setup fee. Freight, rush feasibility/fees, blue inventory, artwork, and final delivery/contact details remain unconfirmed; do not treat this as a final all-inclusive order total. A system-recorded USD 80 full-color setup figure also needs reconciliation before finalization. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:28-28]

## Promoted From Short-Term Memory (2026-07-29)

<!-- openclaw-memory-promotion:memory:memory/2026-07-22.md:16:16 -->
- Oracle CLI repair remains incomplete. In local development build 0.16.0, `/Users/vincent/oracle/src/browser/actions/modelSelection.ts` (notably lines ~626 and ~1165) misclassifies the GPT-5.6 Sol menu item with `aria-haspopup="menu"` as a submenu and then excludes it. Desired behavior: if selection cannot be completed, continue without throwing/aborting. Previous Claude-assisted repair produced no source changes even after configuration restoration; direct local source repair and global installation await authorization.... [score=0.801 recalls=0 avg=0.620 source=memory/2026-07-22.md:16-16]
