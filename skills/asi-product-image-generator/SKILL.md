---
name: "asi-product-image-generator"
description: "Narrow logo removal prompt to preserve reference details"
---

# Proposal: Narrow ASI Logo Cleanup Prompt

## Target Skill

`asi-product-image-generator`

## Problem

The current ASI product-image workflow describes marked-reference cleanup as generating a `净化版参考图`. Even though it says to keep product details, the wording can cause image models to recreate the product image and lose reference information.

## Required Change

When a reference image contains a logo, sample logo, imprint, brand text, platform/manufacturer mark, QR code, watermark, contact info, or URL, the cleanup prompt must be narrow: ask only to remove the logo/mark from the existing product image and preserve everything else.

Do not prompt with wording such as:

- `generate a clean product reference`
- `generate a clean no-logo product image`
- `recreate the product image without logo`
- `create a new product photo`

Use wording like:

```text
Please remove the logo from the product. Keep everything else unchanged, including the product shape, structure, color, material, proportions, angle, background, lighting, shadows, texture, and all non-logo product details. Do not redesign or regenerate the product.
```

For non-logo marks, use the same narrow structure:

```text
Please remove only the visible [mark type] from the product/reference image. Keep everything else unchanged, including product shape, structure, color, material, proportions, angle, background, lighting, shadows, texture, and all non-mark product details. Do not redesign or regenerate the product.
```

## Suggested SKILL.md Edits

In `### 源素材图（参考图）`, replace the cleanup wording with a rule that says:

- If a reference image used for later generation contains logo/sample logo/imprint/marks, use the image-generation skill only to remove those visible marks.
- The cleanup prompt must not ask to generate/recreate a product image.
- The prompt should simply say to remove the logo/mark from the product and keep all other product and image information unchanged.
- Save the cleaned result to `references/cleaned/`, upload it back to `参考图片`, replace the marked original, and verify readback before downstream generation.

In `## 生成商品套图工作流程` step 3, replace `生成净化版参考图` with `只清除参考图中产品上的 logo/标记`; add the English prompt template above.

## Acceptance

Future ASI workers must use the narrow logo-removal prompt before creating downstream white-background, hero, or ASI set images. A cleaned reference must be rejected if the product structure, colors, angle, background, or other non-logo reference information changes materially.
