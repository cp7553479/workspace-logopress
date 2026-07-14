# LP3105 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before doing any work. This is hero regen only, not a full ASI image set.

## Goal

Regenerate only the ASI hero/main image for `LP3105`, upload the new hero image to the `商品主图` field, remove the old hero token, keep all non-hero `商品主图` tokens and the existing `参考图片` / `白底图` tokens unchanged, then read back and report verification.

## Record

- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `商品表`
- Table ID: `tbl3KNB7zP8EQ1d0`
- Product number: `LP3105`
- Record ID: `recuYsACVIpU8x`
- Current old hero token to remove: `ZYKFbfojwoAwI2xhakwcBRcMnqb`
- Old hero filename: `hero_main_oracle_gpt.png`
- `参考图片` token to keep unchanged: `K8kYbImSSoKikixXN6mcKku2n3e`
- `白底图` token to keep unchanged: `XhlPbKzzDolkgOxkgydc9bqlnXf`
- Non-hero `商品主图` tokens to preserve:
  - `ZAGdb4qMbo6kxOxBu2ec5fiSnHh` (`lifestyle_oracle_gpt.png`)
  - `WFBBbEtb1oVko8xf2GycQln2nid` (`selling_point_oracle_gemini.png`)
  - `EdOtb6bXVoQ9a2xjoTGcueKNn9b` (`material_detail_oracle_gpt.png`)
  - `F2hlbyFW4oErJDxDyOTciltVnve` (`sku_color_oracle_gpt.png`)

## Required Workflow

1. Create and use `.temp/LP3105_hero_regen/` with `references/`, `outputs/`, and `uploads/`.
2. Read the current record and download the clean reference image and white-background image for LP3105.
3. Copy the logo files from `skills/asi-product-image-generator/asserts/` into the product references folder.
4. Generate one new 1:1 ASI hero/main image only.
5. Choose `LOGO-BK.png` or `LOGO-WT.png` based on the product/imprint area. The prompt must explicitly name the selected logo file and require the LogoPress `YOUR LOGO` logo to be naturally printed on the printable area.
6. Use Oracle first, alternating Oracle ChatGPT and Oracle Gemini if needed. Only use another reference-capable route after recording why both Oracle paths failed or produced rejected results.
7. Do not use scripts, local compositing, paste-over logo, partial repair, or programmatic image editing for the final image.
8. Upload the accepted image to `商品主图`.
9. Remove old hero token `ZYKFbfojwoAwI2xhakwcBRcMnqb` from `商品主图`, while preserving all four non-hero image tokens listed above.
10. Read back the record and verify:
    - New hero token is present.
    - Old hero token `ZYKFbfojwoAwI2xhakwcBRcMnqb` is absent.
    - All four non-hero `商品主图` tokens are still present.
    - `参考图片` token `K8kYbImSSoKikixXN6mcKku2n3e` is unchanged.
    - `白底图` token `XhlPbKzzDolkgOxkgydc9bqlnXf` is unchanged.

## Final Report

Return:

- Local output path
- Selected logo
- Generation route
- Upload token
- Removed old token
- Preserved non-hero main-image tokens
- Retained reference token
- Retained white-background token
- Verification/readback file path
- Any rejected attempts or route failures
