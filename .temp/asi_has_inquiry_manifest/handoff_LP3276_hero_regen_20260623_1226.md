# Handoff: ASI Hero Regen — LP3276

## Task
Regenerate ONLY the ASI hero/main image for product **LP3276** (record `recuYsACVIydom`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill — this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images)
5. Remove the OLD hero image token `LUz5b5hmgokEQ8xDMJ2czjhdnRh` from `商品主图`
6. Read back to confirm the new hero is present and old hero is removed
7. Return the new hero local file path for parent delivery

## Skills to read first
- `skills/asi-product-image-generator/SKILL.md`
- `/Users/vincent/.openclaw/skills/generate-image/SKILL.md`

## Image generation rules
- Use the `asi-product-image-generator` skill as the governing ASI image workflow
- Must use Oracle (ChatGPT or Gemini) for reference-capable image generation
- English prompts only, 1:1 ratio, no Chinese/price/watermark/QR
- Must show `YOUR LOGO` text (or LogoPress logo file) — do NOT keep any original brand/sample logo
- Hero must show all verified color SKUs in bottom row if multiple colors exist

## Base details
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIydom`
- Old hero token to remove: `LUz5b5hmgokEQ8xDMJ2czjhdnRh`

## Workspace
Create workspace: `.temp/LP3276_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal
- If generation fails, return: error details, fallback evidence, which routes were attempted

