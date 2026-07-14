# LP2566 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This task is hero regen only.

## Scope

- Product number: `LP2566`
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACgfrEQl`
- Workspace: `.temp/LP2566_hero_regen/`

## Goal

Regenerate only the ASI hero/main image for LP2566, upload it to the `商品主图` field, remove the old hero token, preserve existing non-hero main image tokens, then read back and report verification.

Do not generate a full ASI set. Do not modify `参考图片` or `白底图` except for reading/downloading them as references.

## Current Live Readback

`参考图片` must remain unchanged:

- `WqWcbaqpro4f1lxzeS3cV4Vtnjc` - `LP2566_cleaned_reference.png`

`白底图` must remain unchanged:

- `Lwe6bfXjyop5Plxy9tOcOUhln4f` - `LP2566_white_background.png`

Current `商品主图`:

- Old hero to remove after replacement: `Y19UbkAVAoTLLvxNPMucg0fOn7g` - `LP2566_asi_hero.png`
- Preserve: `TAXibBI1OoaxSDxnY4QcQ3ranHc` - `LP2566_asi_lifestyle_wrist.png`
- Preserve: `EwPgbp7taokX2jxMtpecAX3KnHh` - `LP2566_asi_detail_closeup.png`

## Required Output

Generate a new 1:1 ASI hero image:

- Main product large and clean, Amazon/ecommerce hero style.
- Use the current clean reference and white-background product images as reference inputs.
- Use the correct LogoPress logo file as reference input. Choose `LOGO-BK.png` for light product/imprint area or `LOGO-WT.png` for dark product/imprint area.
- The prompt must explicitly name the chosen logo file and require the `YOUR LOGO` imprint on the printable area.
- No Chinese text, no price, no QR code, no watermark, no supplier/platform/manufacturer marks.
- Preserve the real LP2566 product structure, colors, proportions, material, and evidenced variants. Do not invent unsupported SKUs or features.

## Route Rules

- Prefer Oracle image generation.
- Alternate Oracle ChatGPT and Oracle Gemini if retries are needed.
- Use Codex image generation only after both Oracle routes are unavailable, fail, or produce rejected output, and record the evidence.
- Do not use scripts, image processing, pasted logos, local compositing, patching, or programmatic edits for the final image.

## Upload And Verification

After generating an acceptable output:

1. Upload the new hero image to `商品主图`.
2. Remove old hero token `Y19UbkAVAoTLLvxNPMucg0fOn7g`.
3. Preserve `TAXibBI1OoaxSDxnY4QcQ3ranHc` and `EwPgbp7taokX2jxMtpecAX3KnHh`.
4. Read back the record and verify:
   - `商品主图` contains the two preserved tokens plus the new hero token.
   - Old hero token is absent.
   - `参考图片` still contains `WqWcbaqpro4f1lxzeS3cV4Vtnjc`.
   - `白底图` still contains `Lwe6bfXjyop5Plxy9tOcOUhln4f`.

## Report Back

Return:

- local output path
- selected logo file
- generation route used
- upload token
- removed old hero token
- preserved main tokens
- reference and white-background retention
- final readback/verification file path
