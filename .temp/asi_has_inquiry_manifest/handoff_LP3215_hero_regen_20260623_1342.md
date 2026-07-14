# Handoff: ASI Hero Regen - LP3215

## Task
Regenerate ONLY the ASI hero/main image for product **LP3215** (record `recuYsACVILcTO`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material, and selling points
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill - this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `JuiqbKOlpofabmxR60ccqGQKnFe` from `商品主图`
6. Preserve the existing non-hero main image tokens `KnqDbFIj2oBsyKxZ1jCcPHNankc`, `N0ZSbDZZko7C9jx8Vc2c4tNBnti`, and `GydGb0ZvrogvaxxpwS4cH74qnCg`
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
- Record ID: `recuYsACVILcTO`
- Product number: `LP3215`
- Clean reference token: `JmrObqlGIoNZKOxpg00cQoZVnm4`
- White background token: `DI1CbExDMoueHlxlcmncOOzHnG9`
- Old hero token to remove: `JuiqbKOlpofabmxR60ccqGQKnFe`
- Existing non-hero main-image tokens to preserve: `KnqDbFIj2oBsyKxZ1jCcPHNankc`, `N0ZSbDZZko7C9jx8Vc2c4tNBnti`, `GydGb0ZvrogvaxxpwS4cH74qnCg`

## Current readback
- Existing hero filename: `asi_hero_oracle_gemini.png`
- Existing non-hero filenames: `asi_lifestyle_oracle_chatgpt.png`, `asi_rinse_oracle_chatgpt_retry.png`, `asi_bristle_detail_oracle_chatgpt_retry.png`
- Reference filename: `ref_cleaned_oracle_gemini.png`
- White-background filename: `white_background_oracle_chatgpt.png`

## Workspace
Create workspace: `.temp/LP3215_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal, preserved non-hero main image tokens, and reference/white-background token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
