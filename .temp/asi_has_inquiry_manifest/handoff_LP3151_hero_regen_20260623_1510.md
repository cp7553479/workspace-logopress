# LP3151 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This is hero regen only, not a full ASI image set.

## Goal

Regenerate only the ASI hero/main image for `LP3151`, upload the new hero image to the `商品主图` field, remove the old no-logo hero token, keep all non-hero `商品主图` tokens and the existing `参考图片` / `白底图` tokens unchanged, then read back and report verification.

## Record

- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `商品表`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Product number: `LP3151`
- Record ID: `recuYsACVIWP5P`
- Product: Large Capacity Felt Storage Basket Handheld Shopping Bag
- Current old hero token to remove: `WHxxb8lI8oGG8MxgIUzcyIoJnbh`
- Old hero filename: `hero_nologo_oracle_gemini.png`
- `参考图片` token to keep unchanged: `VUdlbTWMrostZ4xWekjcxEv8nMh`
- `白底图` token to keep unchanged: `Rj6DbpojgoAQRWxaKE9c571vnVg`
- Non-hero `商品主图` tokens to preserve:
  - `BsHWbwX9HoCF9sxFabWcjTTwnZe` (`lifestyle_scene_oracle_chatgpt.png`)
  - `NHjfb64r6o4Y4PxKGbjcFUUznlf` (`selling_points_oracle_chatgpt_retry.png`)
  - `SOrWbYkUsooAWSxH0X8cEmMUnrd` (`material_detail_oracle_gemini.png`)
  - `XXoxbe9wHoKjZyxkcbgcKwfNnfb` (`dimension_chart_oracle_chatgpt.png`)
  - `Gzo7b6WoOoVntMxP2oRcTET1nPg` (`sku_color_chart_oracle_gemini.png`)

## Required Workflow

1. Create and use `.temp/LP3151_hero_regen/` with `references/`, `outputs/`, and `uploads/`.
2. Read the current record and download the clean reference image and white-background image for LP3151.
3. Copy the logo files from `skills/asi-product-image-generator/asserts/` into the product references folder.
4. Generate one new 1:1 ASI hero/main image only.
5. Choose `LOGO-BK.png` or `LOGO-WT.png` based on the felt bag/imprint area. The prompt must explicitly name the selected logo file and require the LogoPress `YOUR LOGO` logo to be naturally printed on the printable bag area.
6. Use Oracle first, alternating Oracle ChatGPT and Oracle Gemini if needed. Only use another reference-capable route after recording why both Oracle paths failed or produced rejected results.
7. Do not use scripts, local compositing, paste-over logo, partial repair, or programmatic image editing for the final image.
8. Upload the accepted image to `商品主图`.
9. Remove old hero token `WHxxb8lI8oGG8MxgIUzcyIoJnbh` from `商品主图`, while preserving all five non-hero image tokens listed above.
10. Read back the record and verify:
    - New hero token is present.
    - Old hero token `WHxxb8lI8oGG8MxgIUzcyIoJnbh` is absent.
    - All five non-hero `商品主图` tokens are still present.
    - `参考图片` token `VUdlbTWMrostZ4xWekjcxEv8nMh` is unchanged.
    - `白底图` token `Rj6DbpojgoAQRWxaKE9c571vnVg` is unchanged.

## Final Report

Return:

- Local output path
- Selected logo
- Generation route
- Upload token
- Removed old token
- Preserved non-hero main-image tokens
- Retained reference token
- Retained white-background token
- Verification/readback file path
- Any rejected attempts or route failures
