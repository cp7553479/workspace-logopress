# LP5502 Hero Regeneration Route Log

- Required route order: Oracle ChatGPT first, then Oracle Gemini if needed, then Codex/image CLI if both Oracle routes fail or output is rejected.
- Web prompt research: searched Amazon wine tumbler main-image examples; search showed common listing patterns for insulated/personalized wine tumblers and color variations, so prompt uses white hero background, premium product lighting, and bottom row color SKU display.
- Oracle ChatGPT attempt: `5.5 Medium`, output `.temp/LP5502_hero_regen/outputs/LP5502_hero_main_oracle_chatgpt.png`, references clean product, white-background product, SKU chart, and `LOGO-WT.png`. Failed with: `No images generated ... fetch failed`.
- Oracle Gemini attempt: `gemini-3.5-flash`, output `.temp/LP5502_hero_regen/outputs/LP5502_hero_main_oracle_gemini.png`, same references. Succeeded and saved 1024x1024 PNG.
- Visual check: accepted. The image shows the Sky Blue main tumbler with `YOUR LOGO`, six verified bottom SKU colors (Black, White, Gray, Red, Pink, Sky Blue), and no visible Chinese, price, QR code, watermark, website, or supplier/platform mark.
- Upload: appended new hero to `商品主图`; new token `BZAhbuSm9oIWmhx5Sf7cze4unrb`.
- Cleanup: removed old hero token `SFzNbThZooENGkx5rRzcmcOZnSc` from `商品主图`.
- Verification: `.temp/LP5502_hero_regen/uploads/verification_summary.json` confirms new hero present, old hero absent, all five non-hero `商品主图` tokens preserved, `参考图片` unchanged, and `白底图` unchanged.
