# Handoff: ASI Hero Regen — LP3258

## Task
Regenerate ONLY the ASI hero/main image for product **LP3258** (record `recuYsACVIt4Py`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill — this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `TV97bAy7koWgiwxAbLVc3GYmnYg` from `商品主图`
6. Preserve the existing non-hero/white-background main-image token `GYfXb78bmoY7rNxLbKRcNKu9nmd`
7. Read back to confirm the new hero is present, the old hero is removed, and the preserved image is still present
8. Return the new hero local file path for parent delivery

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
- Record ID: `recuYsACVIt4Py`
- Product name: `Vintage Zippered Leather Pencil Pouch for School & Office`
- Verified colors: medium brown, dark brown, black, dark green, navy blue, burgundy
- Clean reference token: `HnpPb9izEoK6n2xERjucUfswnNf`
- White background token: `YFSVbMOd0oqXgBx2b4fcPBPWnXb`
- Old hero token to remove: `TV97bAy7koWgiwxAbLVc3GYmnYg`
- Existing main-image token to preserve: `GYfXb78bmoY7rNxLbKRcNKu9nmd`

## Workspace
Create workspace: `.temp/LP3258_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal and preserved-token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
