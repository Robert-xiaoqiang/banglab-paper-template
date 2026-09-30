# Changelog

Releases are the `v*` tags of the template repository, and `./banglab update` moves a paper from one to another. A major release breaks papers (a command removed or renamed), a minor release adds something, and a patch release fixes something. A release marked **layout-changing** moves text on the page, so a paper that takes it can gain or lose pages. Take those in drafts, not in the last two weeks before a deadline and not after an arXiv version is out.

## v1.0.0 (2026-09-30) layout-changing

The first release of `banglab.cls`, the title card the lab chose (H), with the file layout, the logo library and the conventions in `AGENTS.md`.

- Title card with the BangLab wordmark and the logos chosen by `\logos{...}` from `assets/` (UdeM, Mila, McGill, Polytechnique, HEC, CIFAR, IBM, Qwen, Alibaba Cloud, ServiceNow, Microsoft, NVIDIA, Google DeepMind), on page one only.
- Body in 11pt XCharter with 13.6pt leading, after the Google DeepMind report class. `[10pt]` and `[12pt]` are class options.
- `\best`, `\second`, `\TODO`, `\authornote` and the `\notesfalse` switch are part of the class.
- Author-year citations by default, `[numbers]` for numbered ones.
- Tested with pdfLaTeX, XeLaTeX and LuaLaTeX on TeX Live 2025 and 2026.
