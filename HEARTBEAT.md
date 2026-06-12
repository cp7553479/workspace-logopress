## ASI Has-Inquiry Image Queue Watch

- Trigger/context: 2026-06-12 12:49 CST, Chen Peng requested ASI image sets for all `商品表` records where `Mark` includes `有询单` and `商品主图` is empty.
- Query scope: Base `SF9ibzjI4a0YFJsDZtKcLvtbnfh`, table `tbl3KNB7zP8EQ1d0`; current filtered count verified by pagination is 656 records.
- Active batch rule: run at most 2 product-image subagents at the same time; each subagent handles exactly one product record.
- Current first batch: LP1277 (`recuYsAdUpxzmv`) and LP1356 (`recuYsAdUp4j8c`). At 2026-06-12 13:00 CST, supervisor found no active subagents despite an earlier memory note saying they were spawned; treat the 13:00 spawn state as authoritative. Current batch file: `.temp/asi_has_inquiry_manifest/current_batch_20260612_1300.md`.
- Active 13:00 CST workers:
  - LP1277 session `agent:global-trading-product:subagent:7844b231-c091-4e6b-af1b-fb7633f1510d`, run `10ad75a5-fa49-4fe2-a3b9-9dedd72e2c1a`.
  - LP1356 session `agent:global-trading-product:subagent:7f8fc6fa-7c10-4785-845a-d2f4c0db7fa6`, run `39fa8069-3d11-48d7-b8f6-01557b844d6a`.
- Required per product: first generate a clean no-logo replacement for `参考图片` that removes original logo/brand/sample marks while preserving plain `YOUR LOGO` text if present, upload it back by replacing the old `参考图片`, read back to verify replacement, then generate/upload ASI套图 to `商品主图`.
- Image path rule: use Oracle ChatGPT and Oracle Gemini alternately. Codex generation is allowed only after Oracle errors; before using Codex for the next image, first test whether Oracle has recovered. Use Codex only if Oracle is still unavailable.
- Supervision rule: check active/recent subagents and local Oracle/image processes. If a subagent has no meaningful progress for a long time, send it a concise nudge asking for current step, blocker, and next action.
- Delivery rule: every generated final image must be sent to the Feishu chat by the parent session in addition to any Base upload.
- Progress rule: update `memory/2026-06-12.md` after each batch completion, blocker, retry, or handoff change.
