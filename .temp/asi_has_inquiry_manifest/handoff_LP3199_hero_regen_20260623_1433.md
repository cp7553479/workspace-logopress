# LP3199 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This task is hero regen only.

## Scope

- Product number: `LP3199`
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIHfSH`
- Workspace: `.temp/LP3199_hero_regen/`

## Goal

Regenerate only the ASI hero/main image for LP3199, upload it to the `商品主图` field, remove the old hero token, preserve the existing non-hero main image token, then read back and report verification.

Do not generate a full ASI set. Do not modify `参考图片` or `白底图` except for reading/downloading them as references.

## Current Live Readback

`参考图片` must remain unchanged:

- `Asn5bwp4soZ0yjx7WhgcRFf3nah` - `reference_cleaned_codex_retry.png`

`白底图` must remain unchanged:

- `YkinbdSnzoPuZoxvIlGc5cxRnab` - `white_background_codex.png`

Current `商品主图`:

- Old hero to remove after replacement: `CHKSbqu64oGZYfxGTO9cqAOUnuf` - `main_hero_codex.png`
- Preserve: `UEdXblkjOoaNt0xs0SvcJPDkn5f` - `main_lifestyle_codex.png`

Known product evidence:

- Product colors: `MEDIUM BROWN MEDIUM BLACK MEDIUM WHITE MEDIUM GREEN MEDIUM ORANGE MEDIUM PINK LIGHT BLUE MEDIUM BLUE MEDIUM YELLOW`
- Chinese color field: `Brown; Black; White; Green; Orange; Pink; Light Blue; Blue; Yellow.`
- Material: `PAPER` / `Paper`

## Required Output

Generate a new 1:1 ASI hero image:

- Main product large and clean, Amazon/ecommerce hero style.
- Use the current clean reference and white-background product images as reference inputs.
- Use the correct LogoPress logo file as reference input. Choose `LOGO-BK.png` for light product/imprint area or `LOGO-WT.png` for dark product/imprint area.
- The prompt must explicitly name the chosen logo file and require the `YOUR LOGO` imprint on the printable area.
- No Chinese text, no price, no QR code, no watermark, no supplier/platform/manufacturer marks.
- Preserve the real LP3199 product structure, colors, proportions, paper material, and evidenced variants. Do not invent unsupported SKUs or features.

## Route Rules

- Prefer Oracle image generation.
- Alternate Oracle ChatGPT and Oracle Gemini if retries are needed.
- Use Codex image generation only after both Oracle routes are unavailable, fail, or produce rejected output, and record the evidence.
- Do not use scripts, image processing, pasted logos, local compositing, patching, or programmatic edits for the final image.

## Upload And Verification

After generating an acceptable output:

1. Upload the new hero image to `商品主图`.
2. Remove old hero token `CHKSbqu64oGZYfxGTO9cqAOUnuf`.
3. Preserve `UEdXblkjOoaNt0xs0SvcJPDkn5f`.
4. Read back the record and verify:
   - `商品主图` contains the preserved token plus the new hero token.
   - Old hero token is absent.
   - `参考图片` still contains `Asn5bwp4soZ0yjx7WhgcRFf3nah`.
   - `白底图` still contains `YkinbdSnzoPuZoxvIlGc5cxRnab`.

## Report Back

Return:

- local output path
- selected logo file
- generation route used
- upload token
- removed old hero token
- preserved main token
- reference and white-background retention
- final readback/verification file path
