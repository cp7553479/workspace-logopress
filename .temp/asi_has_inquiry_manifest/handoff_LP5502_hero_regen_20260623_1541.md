# Handoff: ASI Hero Regen — LP5502

## Task
Regenerate ONLY the ASI hero/main image for product **LP5502** — "10oz stainless steel insulated cup wine tumbler with lid" (record `recuYsBlcDpKN3`).

## Steps
1. Read the `asi-product-image-generator` skill AND `generate-image` skill first
2. Download `参考图片` token `WagUbwNb0ovzxKxK5pZc1kTbn2c` from the Base record
3. Read full record for colors, dimensions, material, SKUs
4. Generate NEW hero/main image using Oracle (ChatGPT or Gemini) per ASI skill rules
5. Upload new hero to `商品主图` field (append)
6. Remove OLD hero token `SFzNbThZooENGkx5rRzcmcOZnSc` from `商品主图`
7. Keep ALL non-hero `商品主图` tokens: NDjkbxq6UoSkE5xzaLvckw3CnCd, GxSvb5lBfojlYuxY5nRczQ1dnQc, CrGNbk9d0o8GO1xRSMocZWXHnAg, By8jbbbfpodIWdx7lfXcOexmnbb, PULCblMNgowud0xgK58cjBgkn8N
8. Keep `参考图片` token `WagUbwNb0ovzxKxK5pZc1kTbn2c` unchanged
9. Keep `白底图` token `VfUfbbUGyofYh6xQ20sc3idfnug` unchanged
10. Read back to confirm new hero present, old hero absent, non-hero tokens preserved
11. Return: local output path, new upload token, generation route, verification file

## Rules
- English prompts, 1:1 ratio, no Chinese/price/watermark/QR
- Must show YOUR LOGO (or LogoPress LOGO-WT.png); do NOT keep original brand/sample logo
- Hero must show all verified color SKUs in bottom row if multiple colors
- If a generation route fails, log it and try next available reference-capable alternative

## Base
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsBlcDpKN3`

## Workspace
`.temp/LP5502_hero_regen/`

