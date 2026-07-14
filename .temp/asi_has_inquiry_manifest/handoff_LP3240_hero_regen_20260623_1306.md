# Handoff: ASI Hero Regen - LP3240

## Task
Regenerate ONLY the ASI hero/main image for product **LP3240** (record `recuYsACVIH4Aq`).

This product already has an existing ASI hero image in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill - this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `WGu1bV4bVosfOfxTNDycOfh1nhd` from `商品主图`
6. Confirm the new hero remains present after old-token removal
7. Confirm `参考图片` and `白底图` remain unchanged
8. Return the new hero local file path for parent delivery

## Skills to read first
- `skills/asi-product-image-generator/SKILL.md`
- `/Users/vincent/.openclaw/skills/generate-image/SKILL.md`

## Image generation rules
- Use the `asi-product-image-generator` skill as the governing ASI image workflow
- Must use Oracle (ChatGPT or Gemini) for reference-capable image generation
- English prompts only, 1:1 ratio, no Chinese/price/watermark/QR
- Must show `YOUR LOGO` text (or LogoPress logo file) - do NOT keep any original brand/sample logo
- Hero must show all verified color SKUs in bottom row if multiple colors exist

## Base details
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIH4Aq`
- Product number: `LP3240`
- Product name: `Multipurpose Portable Foldable USB Receiver Wireless Mouse`
- Verified colors: red, blue, black, white
- Clean reference token: `OJXqblXdmodRj2xcPeic1J81nNc`
- White background token: `MmR3bW2qloR9jKxXCwNcpLtZnPf`
- Old hero token to remove: `WGu1bV4bVosfOfxTNDycOfh1nhd`
- Existing non-hero main-image tokens to preserve: none

## Workspace
Create workspace: `.temp/LP3240_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal and reference/white-background token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
