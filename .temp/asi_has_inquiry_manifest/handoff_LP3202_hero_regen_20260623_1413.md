# Handoff: ASI Hero Regen - LP3202

## Task
Regenerate ONLY the ASI hero/main image for product **LP3202** (record `recuYsACVInTaO`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material, and selling points
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill - this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `C7o5bvo7doxp7OxY6j4cGfgRn9c` from `商品主图`
6. Preserve the existing non-hero main image tokens `VfEsbEHZJoWNATxStq6cOnQIngd` and `NNXIbXMXVoCY5bxoKvDcLxHonbc`
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
- Record ID: `recuYsACVInTaO`
- Product number: `LP3202`
- Clean reference token: `RLYbbwuHjopiFZx6sDicBKwHnCh`
- White background token: `RYSYbmzXAobfs2xKOh4cGe6ynnd`
- Old hero token to remove: `C7o5bvo7doxp7OxY6j4cGfgRn9c`
- Existing non-hero main-image tokens to preserve: `VfEsbEHZJoWNATxStq6cOnQIngd`, `NNXIbXMXVoCY5bxoKvDcLxHonbc`

## Current readback
- Existing hero filename: `asi_hero_variants.png`
- Existing non-hero filenames: `asi_lifestyle_desk_retry.png`, `asi_usage_closeup_retry.png`
- Reference filename: `cleaned_no_logo.png`
- White-background filename: `white_background.png`
- Verified colors: `black`, `white`, `orange`, `pink`, `blue`, `yellow`
- Product name: `5 Colors Highlighter Pen Set with Case Non-Bleed School Supplies`
- Material: `ABS`
- Size: `Length:7.54:in;Width:3.23:in;Height:4.33:in`

## Workspace
Create workspace: `.temp/LP3202_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal, preserved non-hero main image tokens, and reference/white-background token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
