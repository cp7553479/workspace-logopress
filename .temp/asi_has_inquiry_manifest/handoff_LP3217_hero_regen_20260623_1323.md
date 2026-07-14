# Handoff: ASI Hero Regen - LP3217

## Task
Regenerate ONLY the ASI hero/main image for product **LP3217** (record `recuYsACVIUO4i`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material, and selling points
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill - this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `BCFZbi3iNoBkvMxUUkRcRxD7nPc` from `商品主图`
6. Preserve the existing non-hero main image tokens `T8oUbLMtZoGgidxT4pTcqUa9n7d` and `X970bEmL9oai4wxiJ8QcZzYqnfc`
7. Confirm the new hero remains present after old-token removal
8. Confirm `参考图片` and `白底图` remain unchanged
9. Return the new hero local file path for parent delivery

## Skills to read first
- `skills/asi-product-image-generator/SKILL.md`
- `/Users/vincent/.openclaw/skills/generate-image/SKILL.md`

## Image generation rules
- Use the `asi-product-image-generator` skill as the governing ASI image workflow
- Must use Oracle (ChatGPT or Gemini) for reference-capable image generation
- English prompts only, 1:1 ratio, no Chinese/price/watermark/QR
- Must show `YOUR LOGO` text (or LogoPress logo file) - do NOT keep any original brand/sample logo
- Hero must show all verified color SKUs in bottom row if multiple colors exist
- Do not generate a full套图; this is hero regen only

## Base details
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIUO4i`
- Product number: `LP3217`
- Clean reference token: `MP0JbOfU4odGTlxTRKHcCQdCnMZ`
- White background token: `UtYnbxCvioOVhkxs3XYct0sOnLd`
- Old hero token to remove: `BCFZbi3iNoBkvMxUUkRcRxD7nPc`
- Existing non-hero main-image tokens to preserve: `T8oUbLMtZoGgidxT4pTcqUa9n7d`, `X970bEmL9oai4wxiJ8QcZzYqnfc`

## Current readback
- Existing hero filename: `LP3217_asi_hero_retry.png`
- Existing non-hero filenames: `LP3217_asi_detail.png`, `LP3217_asi_lifestyle_chatgpt_retry.png`
- Reference filename: `reference_cleaned_oracle.png`
- White-background filename: `LP3217_white_background.png`

## Workspace
Create workspace: `.temp/LP3217_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal, preserved non-hero main image tokens, and reference/white-background token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
