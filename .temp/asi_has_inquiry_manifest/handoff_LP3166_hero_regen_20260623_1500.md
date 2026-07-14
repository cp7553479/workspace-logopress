# LP3166 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This is hero regen only, not a full ASI image set.

## Goal

Regenerate only the ASI hero/main image for `LP3166`, upload the new hero image to the `商品主图` field, remove the old hero token, keep the existing `参考图片` and `白底图` tokens unchanged, then read back and report verification.

## Record

- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `商品表`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Product number: `LP3166`
- Record ID: `recuYsACVIzGFb`
- Product: 3-in-1 leakproof gym/cycling misting keep-cool water bottle
- Material: plastic
- Confirmed dimensions: `2.95 in x 2.95 in x 9.84 in`
- Current `商品主图` old hero token to remove: `PS02bKFs2oGb0fxu1yPc9E4JnFb`
- `参考图片` token to keep unchanged: `FnqnbsFpxoIqYIxWFDycB5senXd`
- `白底图` token to keep unchanged: `SJsPbAMQZoPe5txnzhCcU1cgnHg`

## Required Workflow

1. Create and use `.temp/LP3166_hero_regen/` with `references/`, `outputs/`, and `uploads/`.
2. Read the current record and download the clean reference image and white-background image for LP3166.
3. Copy the logo files from `skills/asi-product-image-generator/asserts/` into the product references folder.
4. Generate one new 1:1 ASI hero/main image only.
5. Choose `LOGO-BK.png` or `LOGO-WT.png` based on the bottle/imprint area. The prompt must explicitly name the selected logo file and require the LogoPress `YOUR LOGO` logo to be naturally printed on the printable area.
6. Use Oracle first, alternating Oracle ChatGPT and Oracle Gemini if needed. Only use another reference-capable route after recording why both Oracle paths failed or produced rejected results.
7. Do not use scripts, local compositing, paste-over logo, partial repair, or programmatic image editing for the final image.
8. Upload the accepted image to `商品主图`.
9. Remove old hero token `PS02bKFs2oGb0fxu1yPc9E4JnFb` from `商品主图`, while preserving any non-hero image tokens if present. The precheck showed only this one main token, so final `商品主图` should contain the new hero token unless live readback shows additional non-hero tokens.
10. Read back the record and verify:
    - New hero token is present.
    - Old hero token `PS02bKFs2oGb0fxu1yPc9E4JnFb` is absent.
    - `参考图片` token `FnqnbsFpxoIqYIxWFDycB5senXd` is unchanged.
    - `白底图` token `SJsPbAMQZoPe5txnzhCcU1cgnHg` is unchanged.

## Final Report

Return:

- Local output path
- Selected logo
- Generation route
- Upload token
- Removed old token
- Retained reference token
- Retained white-background token
- Verification/readback file path
- Any rejected attempts or route failures

