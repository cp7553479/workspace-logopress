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

## Promoted From Short-Term Memory (2026-07-30)

<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:26:26 -->
- 2026-07-25 — LP1169 completed: LP1169 (`recuYsA78zsRux`) was independently verified and delivered. The protected clean reference `BvSkbwOWYorH2ExeeRYcq4uJn6c` and six single-colour white-background assets remained unchanged. `商品主图` contains exactly the accepted lifestyle `ULyjbZ0DjoqfFKxhANEcCnNjnrh`, six-colour SKU chart `WLbPbwf67ooIMyxi6pEctAf5nY5`, and hero `Qnn9bRur6oynylxeUOjcrnTynQE`. The hero has only a single plain-text `YOUR LOGO` imprint, no LP graphic mark. Do not redispatch this record. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:26-26]
<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:7:10 -->
- Durable workflow preferences reaffirmed: send Vincent every generated ASI image, including rejected candidates with a clear status/reason. For a rejected Base attachment, the assigned worker may delete only the explicitly identified attachment after a fresh lock and Base reread, regenerate, then the main session independently verifies before delivery. - Image acceptance rule: a lower-right sparkle/four-point-star mark is acceptable and must never be requested or mentioned in image-generation prompts. If an exact LP icon cannot be reproduced, a clear text-only `YOUR LOGO` imprint is allowed.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:7-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:17:18 -->
- 2026-07-25 — LP1681 hero correction: Vincent explicitly rejected LP1681's prior hero because it included an extra LP graphic mark. The replacement must show only the text “YOUR LOGO”, with no LP icon or graphic; the accepted lifestyle image remains unchanged. A scoped redo was dispatched after reviewing the Base state.; Vincent supplied a reference photo of a beige drawstring jewelry pouch on cream fabric with pearls and a jewelry-box setting; retain it as a potential visual reference unless he specifies a different task. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:17-18]
<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:22:22 -->
- 2026-07-25 — LP1900 display fidelity pause: LP1900 (`recuYsA78zBmI1`) has stable protected assets: clean reference `AZqObKkcFo5smFxLTNBcJZr4nDh` and white background `AXnwb7jyEovynGxcAV4c68R6nrh`. Stage-2 lifestyle, SKU, dimensions, and text-only hero candidates all visibly changed the source-required LED display from `30` to `80`. They are rejected; after an erroneous temporary upload/delivery, all four explicitly identified main-image attachments were immediately removed under the product lock. Final Base readback confirms `商品主图` is empty. Resume only with a generation path that preserves the exact `30` display. [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:22-22]
<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:3:6 -->
- LP6587 / Paztora: 1,000 brown PU card holders, same-color debossed isotype only (no “EVER” wordmark), shipped express to Miami 33185. PI `LP26072201` was created at USD 650 and a verified two-page PDF was sent. The PI XLSX-to-PDF workflow now requires the user's consent before conversion and uses `skills/print-pi/scripts/convert_xlsx_to_pdf.py` with page-render verification. - Shipping rule: Shanghai UPS red-label small-parcel U.S. rate sheet is tax included and excludes customs clearance; small-parcel rush surcharge is fixed at RMB 100.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:3-6]
<!-- openclaw-memory-promotion:memory:memory/2026-07-25.md:11:14 -->
- LP1681 (`recuYsA4H0bWBX`) must be resumed only after a fresh protected-field baseline read: while the worker ran, `商品主图` changed externally to lifestyle attachment `KVhwbPTbcovjccxdbEBc8Y5OnPh` at revision 10858. The worker made no Base write or delivery after detecting this. Reference and white-background tokens remained correct; a locally validated alternate lifestyle candidate exists at `.temp/LP1681_asi_recuYsA4H0bWBX/outputs/LP1681_lifestyle_codex.png`, but no corrected text-only hero was generated.... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-25.md:11-14]
<!-- openclaw-memory-promotion:memory:memory/2026-07-23.md:32:35 -->
- UPS small-parcel USA rate card — 2026-07-23 11:42 CST: User supplied the image titled “上海UPS红单小货价格（US）包税不包清关”. Treat it as the current Shanghai UPS red-label small-parcel USA rate card; tax included, customs clearance excluded. The image does not state a currency, so do not label its numeric prices as USD or RMB without confirmation.; Exact displayed weight/price pairs: 0.5pak→220; 1.00→240; WPX0.5→240; 1.00→260; 1.50→300; 2.00→320; 2.50→400; 3.00→440; 3.50→470; 4.00→520; 4.50→560; 5.00→590; 5.50→610; 6.00→630; 6.50→650; 7.00→720; 7.50→750; 8.00→790; 8.50→840; 9.00→890; 9.50→940; 10.00→960; 10.50→1000; 11.00→1030; 11.50→1050;... [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-23.md:32-35]
