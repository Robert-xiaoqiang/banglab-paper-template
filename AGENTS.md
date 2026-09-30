# Paper conventions

These rules hold for every paper built on `banglab.cls`, for the people writing it and for coding agents. Claude Code reads this file through `CLAUDE.md`, and Codex reads it directly. Keep it short: a rule belongs here only if breaking it costs a reader or a co-author something.

## Files

- `main.tex` holds the class options, the front matter and all the text, sections and appendix included.
- The abstract is `\abstract{...}` in the preamble, or the `abstract` environment before `\maketitle`. It cannot hold `\verb`, or a `#` or `%` inside a link.
- `figures/<name>.tex` (TikZ or pgfplots) or `figures/<name>.pdf` holds the drawing only. The `figure` environment, the caption and the label stay in `main.tex`.
- `tables/<name>.tex` holds the `tabular` only. The `table` environment, the caption and the label stay in `main.tex`.
- `references.bib` is the one bibliography. Keys follow `<first author's surname><year><first title word>`, as in `vaswani2017attention`.
- `commands.tex` holds the packages and macros the paper adds. Never edit the library files (`banglab.cls`, `assets/`, this file) in a paper: `./banglab update` replaces them, and `banglab.lock` records their hashes so an edit is caught. Change their behaviour from `commands.tex`, or propose the change to the template.
- `assets/` holds the logos and icons the class draws. `\logos{udem,mila,...}` in `main.tex` picks the ones the title card shows. Show only the logos of the institutions the authors belong to.
- File names are lowercase words joined by hyphens and say what the file holds, never a number or a version (`main-results.tex`, not `table2.tex` or `results-v2.tex`).

## Labels and cross-references

- Prefixes: `sec:` for sections and subsections, `app:` for appendix sections, `fig:`, `tab:`, `eq:`, `alg:`, and `thm:`, `lem:`, `def:` for theorem-like environments.
- A figure or table label repeats its file name, so `figures/overview.tex` is `fig:overview` and `tables/main-results.tex` is `tab:main-results`. A section label is its heading in lowercase with hyphens, so Related Work is `sec:related-work`.
- Put `\label` right after `\caption`, or right after `\section`.
- Refer with `\cref{...}`, and with `\Cref{...}` at the start of a sentence. Never type "Figure 3" or "Section 2" by hand.
- Label only the equations the text refers to.

## Citations

- A cited work that is a noun in the sentence, its subject or its object, takes `\citet`: `\citet{vaswani2017attention} introduced the Transformer.`
- A citation that supports a claim or a named thing takes `~\citep`, right after what it supports: `Transformers~\citep{vaswani2017attention} dominate ...`. The `~` keeps it on the same line.
- Several works behind one claim share one `\citep{a,b,c}`.
- Never make a parenthetical citation the noun of a sentence ("as shown in \citep{x}").
- Author-year is the default. `\documentclass[numbers]{banglab}` switches to [1], and `\citet` and `\citep` need no change. Do not load natbib again.

## Headings

- `\section` and `\subsection` only. Below them, use a run-in `\paragraph{Heading.}`. The class warns when `\subsubsection` appears.
- Headings in Title Case.
- Maths in a title or heading goes through `\texorpdfstring{$\pi$}{pi}`, so the PDF bookmarks get plain text.

## Figures and tables

- Diagrams and plots are vector (TikZ, pgfplots or PDF). Raster images only for photos and screenshots.
- Size against the column, `width=\linewidth`, never in absolute units.
- Place floats with `[t]`. Use `figure*` and `table*` for anything wider than one column, so the paper also works with `[twocolumn]`.
- Tables use booktabs (`\toprule`, `\midrule`, `\bottomrule`) and no vertical rules. Keep one number of decimals down a column. Mark the best entry with `\best{}` and the second with `\second{}`.
- Charts use `chartpurple` for the method and `chartblue` for a baseline.

## Mathematics

- Named operators use `\operatorname{...}` or `\DeclareMathOperator` in `commands.tex`. Text in subscripts uses `\mathrm` (`x_{\mathrm{train}}`).
- A displayed equation is part of its sentence and ends with the sentence's punctuation.
- Notation is defined once as a macro in `commands.tex`, so a symbol changes in one place.

## Text

- One sentence per line in `main.tex`, so diffs and the Overleaf history show whole sentences.
- `e.g.,` and `i.e.,` with a comma, `\%` for percent, `--` for ranges (`1--5`), and ``` ``quotes'' ``` for quotation marks.
- `\emph` for emphasis, `\texttt` for code and identifiers, `\method{}` for the method's name.
- No `\\`, `\vspace` or `\newpage` in running text to fix the layout.
- Notes to co-authors use `\TODO{...}` or `\authornote{Name}{...}`. `\notesfalse` in `commands.tex` hides every note before submission.

## Building

- pdfLaTeX through `latexmk -pdf main.tex`, which is what Overleaf runs. Keep the `\pdfoutput=1` line at the top of `main.tex`.
- A change is done when the build has no `^! ` lines and no undefined references or citations in `main.log`.
- For arXiv, upload the generated `main.bbl` with the sources.
