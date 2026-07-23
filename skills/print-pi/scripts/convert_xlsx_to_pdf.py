#!/usr/bin/env python3
"""Export an Excel workbook to PDF with Numbers and render every PDF page for review."""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


RENDER_SWIFT = r'''
import AppKit
import Foundation
import PDFKit

let args = CommandLine.arguments
guard args.count == 3, let document = PDFDocument(url: URL(fileURLWithPath: args[1])) else {
    fputs("Unable to open PDF.\n", stderr); exit(2)
}
let output = URL(fileURLWithPath: args[2], isDirectory: true)
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
print("pages=\(document.pageCount)")
for index in 0..<document.pageCount {
    guard let page = document.page(at: index) else { exit(3) }
    let box = page.bounds(for: .mediaBox)
    guard box.width > 0 && box.height > 0 else { exit(4) }
    let scale: CGFloat = 2
    let image = NSImage(size: NSSize(width: box.width * scale, height: box.height * scale))
    image.lockFocus()
    NSColor.white.setFill()
    NSBezierPath(rect: NSRect(origin: .zero, size: image.size)).fill()
    let context = NSGraphicsContext.current!.cgContext
    context.scaleBy(x: scale, y: scale)
    page.draw(with: .mediaBox, to: context)
    image.unlockFocus()
    guard let data = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: data),
          let png = bitmap.representation(using: .png, properties: [:]) else { exit(5) }
    let destination = output.appendingPathComponent(String(format: "page-%02d.png", index + 1))
    try png.write(to: destination)
    print("page=\(index + 1) size=\(Int(box.width))x\(Int(box.height)) preview=\(destination.path)")
}
'''


APPLESCRIPT = r'''
on run argv
    tell application "Numbers"
        set docRef to open (POSIX file (item 1 of argv))
        tell docRef to export to (POSIX file (item 2 of argv)) as PDF
        close docRef saving no
    end tell
end run
'''


def run(command: list[str], *, label: str) -> str:
    result = subprocess.run(command, text=True, capture_output=True)
    if result.returncode:
        detail = (result.stderr or result.stdout).strip()
        raise RuntimeError(f"{label} failed: {detail}")
    return result.stdout


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Export XLSX to PDF with Numbers, then render every page as PNG for visual QA."
    )
    parser.add_argument("input_xlsx", type=Path)
    parser.add_argument("output_pdf", type=Path)
    parser.add_argument(
        "--preview-dir",
        type=Path,
        help="Directory for page-01.png, page-02.png, etc. Defaults beside the PDF.",
    )
    args = parser.parse_args()

    source = args.input_xlsx.expanduser().resolve()
    destination = args.output_pdf.expanduser().resolve()
    preview_dir = (args.preview_dir or destination.with_name(destination.stem + "-pages")).expanduser().resolve()
    if source.suffix.lower() != ".xlsx" or not source.is_file():
        parser.error(f"Input must be an existing .xlsx file: {source}")
    if shutil.which("osascript") is None or not Path("/Applications/Numbers.app").exists():
        raise RuntimeError("Numbers is required for fidelity-preserving XLSX export on this Mac.")
    if shutil.which("swift") is None:
        raise RuntimeError("Swift/PDFKit is required to validate and render every PDF page.")

    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.exists():
        destination.unlink()
    if preview_dir.exists():
        shutil.rmtree(preview_dir)

    with tempfile.NamedTemporaryFile("w", suffix=".applescript", delete=False) as script:
        script.write(APPLESCRIPT)
        applescript = Path(script.name)
    try:
        run(["osascript", str(applescript), str(source), str(destination)], label="Numbers PDF export")
    finally:
        applescript.unlink(missing_ok=True)
    if not destination.is_file() or destination.stat().st_size == 0:
        raise RuntimeError("Numbers reported success but did not create a PDF.")

    with tempfile.NamedTemporaryFile("w", suffix=".swift", delete=False) as script:
        script.write(RENDER_SWIFT)
        renderer = Path(script.name)
    try:
        report = run(["swift", str(renderer), str(destination), str(preview_dir)], label="PDFKit page validation")
    finally:
        renderer.unlink(missing_ok=True)
    previews = sorted(preview_dir.glob("page-*.png"))
    if not previews:
        raise RuntimeError("PDFKit validation did not render any page previews.")
    print(f"pdf={destination}")
    print(report.strip())
    print(f"preview_dir={preview_dir}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(1)
