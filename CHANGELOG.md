# Changelog

Releases are the `v*` tags of the template repository, and `./banglab update` moves a paper from one to another. A major release breaks papers (a command removed or renamed), a minor release adds something, and a patch release fixes something. A release marked **layout-changing** moves text on the page, so a paper that takes it can gain or lose pages. Take those in drafts, not in the last two weeks before a deadline and not after an arXiv version is out.

## v2.0.0 (2026-09-30)

arXiv deleted the title-card logos of the first two papers on this template. Its Check Files step scans the paper's `.tex` files for literal include paths, marks every uploaded file nothing names as unused, and deletes the marked files before compiling. The class reached the logos through a macro, so they were invisible to it. This release makes the paper's own sources name every graphic, and adds a tool that runs arXiv's check before upload.

- `\logos{...}` now takes one `\includegraphics{<path>}` per logo, with the path written out: `\logos{\includegraphics{assets/logo-udem.pdf}\includegraphics{assets/logo-mila.pdf}}`. The class still sizes and arranges them. The v1 form `\logos{udem,mila}` is an error whose message spells out the replacement line. `\logos{}` means no logos, and a missing `\logos` is a warning. Options on a logo are ignored with a warning.
- `\definelogo{name}{path}{scale}` is keyed by the path, and a paper's own logo lives under `figures/` and is registered from `commands.tex`.
- The Hugging Face mark beside `\huggingface` is drawn by the class. `assets/icon-huggingface.png` is removed from the library.
- `./banglab arxiv <paper>` builds and verifies the arXiv zip: the files the compile read plus `main.bbl`, arXiv's own file check (`./banglab arxiv --setup-preflight` installs it) and a built-in emulation of it, a standalone compile of the zip, and `arxiv_submission.zip` written only when all of that passed. It refuses a paper whose `banglab.lock` is older than v2.0.0, one that redefines a class internal, one that still prints `\TODO` notes, and one that reads a file outside the paper and the TeX distribution. `--out`, `--keep` and `--no-preflight` are its options.
- `./banglab init` and `./banglab update` take `--no-commit`, and their git commands touch only the paper directory, so a paper can sit inside a larger repository.
- The scaffold `.gitignore` ignores `arxiv_submission.zip`. A paper that wants the zip tracked, for download from Overleaf, deletes that line.
- The class includes no graphic itself: its registry only maps each path to a height. `iftex` is loaded before its first use.
- The scaffold's `commands.tex` adds a `\crefalias` hook for each theorem-like environment that shares the theorem counter, because cleveref on arXiv's TeX Live 2025 otherwise names them all "Theorem" (tested on TeX Live 2025 and 2026). An existing paper with such environments copies those three lines.
- Not layout-changing: the title card is pixel-identical to v1.0.0 apart from the drawn Hugging Face mark.

## v1.0.0 (2026-09-30) layout-changing

The first release of `banglab.cls`, the title card the lab chose (H), with the file layout, the logo library and the conventions in `AGENTS.md`.

- Title card with the BangLab wordmark and the logos chosen by `\logos{...}` from `assets/` (UdeM, Mila, McGill, Polytechnique, HEC, CIFAR, IBM, Qwen, Alibaba Cloud, ServiceNow, Microsoft, NVIDIA, Google DeepMind), on page one only.
- Body in 11pt XCharter with 13.6pt leading, after the Google DeepMind report class. `[10pt]` and `[12pt]` are class options.
- `\best`, `\second`, `\TODO`, `\authornote` and the `\notesfalse` switch are part of the class.
- Author-year citations by default, `[numbers]` for numbered ones.
- Tested with pdfLaTeX, XeLaTeX and LuaLaTeX on TeX Live 2025 and 2026.
