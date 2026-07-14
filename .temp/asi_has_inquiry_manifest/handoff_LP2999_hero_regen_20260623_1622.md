# LP2999 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This is hero regen only, not a full ASI image set.

## Goal

Regenerate only the ASI hero/main image for `LP2999`, upload the new hero image to the `商品主图` field, remove the old hero token, keep the existing `参考图片`, `白底图`, and non-hero `商品主图` tokens unchanged, then read back and report verification.

## Record

- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `商品表`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Product number: `LP2999`
- Record ID: `recuYsACVIbm5I`
- Product name: `7 inch rectangular DIY couple memorial wooden photo frame`
- Current old hero token to remove: `PQC2bFBfpoQwVsx8JzYcThtUnOc`
- Old hero filename: `lp2999_hero.png`
- `参考图片` token to keep unchanged: `D7KrbYbjjoB3EXxED7yc5TTFngg`
- `参考图片` filename: `clean_reference.png`
- `白底图` token to keep unchanged: `AuLHb1R8boh9BXxsoQTcUToKnMb`
- `白底图` filename: `lp2999_white_background.png`
- Non-hero `商品主图` tokens to preserve:
  - `WbbTb1CVvowdR8xPSBRc2lqlnUf` (`lp2999_scene.png`)
  - `EL3XbsMqeoPYeDx7GnPcDhzNngh` (`lp2999_selling_point_v2.png`)
  - `LhT8bHPCKoGBGtxwqATcLXhhn2d` (`lp2999_dimensions.png`)
  - `UDvmbslWsorILKxlVeucVo3znnh` (`lp2999_material_detail.png`)

## Product Facts To Preserve

- Product type: rectangular 7 inch DIY memorial/photo frame
- Material from record: acrylic plastic; description also mentions wooden picture frame, so preserve the actual visual evidence from the reference images over generic wording.
- Color: black
- Size: about 15.9 x 21 cm
- Product use: decorative photo frame / memorial display

Do not invent extra accessories, extra colors, QR codes, supplier names, URLs, pricing, rush-service badges, promotional discounts, or unsupported claims.

## Required Workflow

1. Create and use `.temp/LP2999_hero_regen/` with `references/`, `outputs/`, and `uploads/`.
2. Read the current record and download the clean reference image and white-background image for LP2999.
3. Copy the logo files from `skills/asi-product-image-generator/asserts/` into the product references folder.
4. Generate one new 1:1 ASI hero/main image only.
5. Choose `LOGO-BK.png` or `LOGO-WT.png` based on the frame/imprint area. The prompt must explicitly name the selected logo file and require the LogoPress `YOUR LOGO` logo to be naturally printed on the appropriate printable area.
6. Use Oracle first, alternating Oracle ChatGPT and Oracle Gemini if needed. Only use another reference-capable route after recording why both Oracle paths failed or produced rejected results.
7. Do not use scripts, local compositing, paste-over logo, partial repair, or programmatic image editing for the final image.
8. Upload the accepted image to `商品主图`.
9. Remove old hero token `PQC2bFBfpoQwVsx8JzYcThtUnOc` from `商品主图`.
10. Read back the record and verify:
    - New hero token is present.
    - Old hero token `PQC2bFBfpoQwVsx8JzYcThtUnOc` is absent.
    - The four non-hero `商品主图` tokens listed above are still present.
    - `参考图片` token `D7KrbYbjjoB3EXxED7yc5TTFngg` is unchanged.
    - `白底图` token `AuLHb1R8boh9BXxsoQTcUToKnMb` is unchanged.

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
