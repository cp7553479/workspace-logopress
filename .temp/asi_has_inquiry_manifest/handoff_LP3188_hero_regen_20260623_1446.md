# LP3188 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This task is hero regen only.

## Scope

- Product number: `LP3188`
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIE192`
- Workspace: `.temp/LP3188_hero_regen/`

## Goal

Regenerate only the ASI hero/main image for LP3188, upload it to the `商品主图` field, remove the old hero token, then read back and report verification.

Do not generate a full ASI set. Do not modify `参考图片` or `白底图` except for reading/downloading them as references.

## Current Live Readback

`参考图片` must remain unchanged:

- `GiijbQqXUoIJhxxeNhtcX9Afnof` - `LP3188_clean_reference.png`

`白底图` must remain unchanged:

- `RolSbKFXCoCkSLxlyeOc6nkYngd` - `LP3188_white_background.jpg`

Current `商品主图`:

- Old hero to remove after replacement: `F1ulbtZ3gonqkNxtxBlcJVeInxe` - `LP3188_asi_main_hero.jpg`
- No non-hero main image token exists to preserve.

Known product evidence:

- Product name: `Windproof Warm Ski Bike Cycling Neck Warmer Winter Face Mask Balaclava`
- Description: windproof winter balaclava / neck warmer / face mask for skiing, cycling, biking, motorcycling, running, trekking, hunting, tactical training, and cold-weather outdoor activities. Covers head, neck, and face except eyes. Drawstring bottom and back neck slit. Custom printed logos supported.
- Product colors: `OTHER=Custom Color`
- Chinese color field: `custom color`
- Material: `POLYESTER` / `Polyester`

## Required Output

Generate a new 1:1 ASI hero image:

- Main product large and clean, Amazon/ecommerce hero style.
- Use the current clean reference and white-background product images as reference inputs.
- Use the correct LogoPress logo file as reference input. Choose `LOGO-BK.png` for light product/imprint area or `LOGO-WT.png` for dark product/imprint area.
- The prompt must explicitly name the chosen logo file and require the `YOUR LOGO` imprint on the printable area.
- No Chinese text, no price, no QR code, no watermark, no supplier/platform/manufacturer marks.
- Preserve the real LP3188 product structure, proportions, polyester fabric material, and evidenced custom-color nature. Do not invent unsupported SKUs, claims, or accessories.

## Route Rules

- Prefer Oracle image generation.
- Alternate Oracle ChatGPT and Oracle Gemini if retries are needed.
- Use Codex image generation only after both Oracle routes are unavailable, fail, or produce rejected output, and record the evidence.
- Do not use scripts, image processing, pasted logos, local compositing, patching, or programmatic edits for the final image.

## Upload And Verification

After generating an acceptable output:

1. Upload the new hero image to `商品主图`.
2. Remove old hero token `F1ulbtZ3gonqkNxtxBlcJVeInxe`.
3. Read back the record and verify:
   - `商品主图` contains the new hero token.
   - Old hero token is absent.
   - `参考图片` still contains `GiijbQqXUoIJhxxeNhtcX9Afnof`.
   - `白底图` still contains `RolSbKFXCoCkSLxlyeOc6nkYngd`.

## Report Back

Return:

- local output path
- selected logo file
- generation route used
- upload token
- removed old hero token
- reference and white-background retention
- final readback/verification file path
