# LP3070 ASI Hero Regen Handoff

Use the `asi-product-image-generator` skill for ASI image rules before taking action.
Also read `.temp/asi_has_inquiry_manifest/worker_instructions.md`.

Task: regenerate the ASI hero/main image only for LP3070, then upload it to 商品主图 and remove the old hero token only.

Product:
- Product_Number: LP3070
- Record ID: recuYsACVIDm7w
- Name: Pu leather self-adhesive phone wallet card holder kickstand
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table ID: tbl3KNB7zP8EQ1d0

Current tokens:
- Reference token to retain: BNJlbTwuwoPkwcxS1LicwFoMngb
- White-background token to retain: VR4FbTukNoI4nsxUrgic5iqXngd
- Old hero token to remove after successful upload: Ez7xboKaVoXZvGxVvquckK4Innd
- Non-hero 商品主图 token to preserve: TlFmbM6vtolfBexrbB2clGkKnq6

Workspace:
- `.temp/LP3070_hero_regen/`
- Record snapshot: `.temp/LP3070_hero_regen/record_before.json`

Requirements:
- Generate one clean ASI hero/main image with LogoPress logo applied when supported by the product/reference evidence.
- Do not regenerate the full ASI set.
- Do not remove or overwrite reference image, white-background image, or non-hero 商品主图.
- Upload serially with `lark-cli base +record-upload-attachment`.
- Remove only old hero token `Ez7xboKaVoXZvGxVvquckK4Innd` after the new upload succeeds.
- Verify with a fresh Base readback and write a verification file under `.temp/LP3070_hero_regen/uploads/`.
- Final report must include output path, new upload token, removed old token, preserved token, and verification file path.
