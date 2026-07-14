# Handoff: ASI Hero Regen - LP3229

## Task
Regenerate ONLY the ASI hero/main image for product **LP3229** (record `recuYsACVIvAOI`).

This product already has existing ASI main images in the Base. You must:
1. Read the current `参考图片` (clean reference) from the Base record
2. Read the full record to understand product name, colors, dimensions, material, and selling points
3. Generate a NEW hero/main image using the `asi-product-image-generator` skill - this is **mandatory**
4. Upload the new hero to the `商品主图` field (append, do NOT remove existing images first)
5. Remove the OLD hero image token `PuifbprCQoLoBoxJkm0cV9RVnEg` from `商品主图`
6. Preserve the non-hero main image token `UIcub1aUJo0Gw0xQjhscHjpEntg`
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

## Base details
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `tbl3KNB7zP8EQ1d0`
- Record ID: `recuYsACVIvAOI`
- Product number: `LP3229`
- Product name: `Multifunctional Portable Moisture-Proof Cotton Outdoor Blanket`
- ASI name: `Multifunctional portable moisture-proof outdoor blanket`
- Product summary: `多功能便携防潮户外毯，优质棉质，防水防潮，轻盈便携，多场景适用，可保暖可作野餐垫，贴心实用礼物，支持加急。`
- English description: `Our travel blanket moisture-proof mat is made of high-quality materials and has excellent waterproof and moisture-proof performance. It can effectively block ground moisture and provide you with a dry and comfortable resting environment when camping, picnicking or traveling outdoors. The moderate thickness will not add too much burden to your luggage, but can provide sufficient comfort. Multi-purpose design, it can be used as a blanket to keep you warm on a cold night, or it can be spread on the ground as a picnic mat. It is light and easy to carry, and you can unfold it anytime and anywhere. Whether it is in the mountains, at the seaside or in the park, it can be your intimate companion. It is also a thoughtful and practical gift for family and friends.`
- Verified colors: green, gray, black, blue
- Material: cotton
- Product dimensions: `Length:14.57:in;Width:9.06:in;Height:2.36:in`
- Imprint method: `Full color/Silkscreen/Unimprinted/`
- Imprint location: `Centered on Front or as you request`
- Clean reference token: `F2HsbkxrYoBPh5xW7bhcw3yXnzl`
- White background token: `IV3nbVpG7okAgJxtodkc6h7snlb`
- Old hero token to remove: `PuifbprCQoLoBoxJkm0cV9RVnEg`
- Existing non-hero main-image tokens to preserve: `UIcub1aUJo0Gw0xQjhscHjpEntg`

## Workspace
Create workspace: `.temp/LP3229_hero_regen/`

## Output
- Return: new hero local file path, new upload token, confirmation of old token removal, preserved non-hero main image token, and reference/white-background token retention
- If generation fails, return: error details, fallback evidence, which routes were attempted
