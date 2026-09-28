# BangLab paper template

`banglab.cls` typesets arXiv preprints for BangLab at Université de Montréal and Mila. The front matter sits in one tinted card that opens with the BangLab wordmark and closes with the UdeM and Mila logos, and the wordmark and logos appear on page one only. Headings, caption labels and the title block are set in Inter, the closest free match to Mila's typeface, over a Latin Modern body. The sample paper in this project doubles as the manual.

## Quick start

Copy the project (on Overleaf, Menu → Copy Project), then edit `main.tex` for the front matter and `sections/` for the text.

```latex
\documentclass{banglab}          % [numbers] for [1] citations, [twocolumn] for two columns
\input{commands}

\title{Your Title}
\reportlabel{Technical Report}
\author[1,2,*]{First Author}
\author[1,2,\dagger]{Senior Author}
\affiliation[1]{Mila -- Quebec AI Institute}
\affiliation[2]{Universit\'e de Montr\'eal}
\contribution[*]{Equal contribution}
\contribution[\dagger]{Corresponding author}
\abstract{\input{sections/abstract}}
\date{\today}
\correspondence{\email{you@mila.quebec}}
\github{\href{https://github.com/org/repo}{github.com/org/repo}}
```

## Layout

```
main.tex          class options, front matter, and the order of the sections
banglab.cls       the class, not edited per paper
brand/            logos and icons the class draws
commands.tex      packages and macros this paper adds
sections/         one file per section: abstract, introduction, related-work,
                  method, experiments, conclusion, appendix
figures/          drawings only (TikZ, pgfplots or PDF), captions stay in sections/
tables/           tabular bodies only, captions stay in sections/
bib/              references.bib
AGENTS.md         writing and LaTeX conventions, for people and agents
CLAUDE.md         points Claude Code at AGENTS.md
```

A label repeats the file it points to, so `figures/overview.tex` is `\label{fig:overview}` and `tables/main-results.tex` is `\label{tab:main-results}`. `AGENTS.md` has the rest: label prefixes, `\citet` against `~\citep`, headings down to `\subsection`, and the table and figure rules.

## Citations

Author-year is the default. `\documentclass[numbers]{banglab}` switches to numbered citations, and `\citet` and `\citep` need no change in the text. Keep `\bibliographystyle{plainnat}` in both modes, or use `unsrtnat` to number references in order of first citation.

## What the class provides

| Command or environment | Use |
| --- | --- |
| `\author[marks]{Name}`, `\affiliation[mark]{...}`, `\contribution[mark]{...}` | Authors with affiliation and contribution marks, where `\dagger` also works as a mark |
| `\abstract{\input{sections/abstract}}`, or `\begin{abstract}...\end{abstract}` before `\maketitle` | The abstract inside the card. The file form accepts anything, while the environment cannot hold `\verb` or a `#` or `%` inside a link |
| `\date`, `\correspondence`, `\github`, `\huggingface`, `\projectpage`, `\blogpost`, `\metadata[Key][\faIcon]{Value}` | Metadata lines with icons |
| `\reportlabel{...}` | The label beside the wordmark, Preprint by default |
| `\teaser{figure}{caption}` | An optional full-width figure under the card |
| `\labname` | The BangLab wordmark in running text |
| `takeaway`, `promptbox` | A tinted box for a finding, and a box for prompts or model outputs |
| `\beginappendix`, `\beginappendix*` | The appendix heading with, or without, a contents list |

The colours `milapurple` (`#662E7D`), `udemblue` (`#0057AC`), `labink`, `labgrey`, `labtint` and `labrule` are available to the paper, and `chartpurple` with `chartblue` is a two-series pair checked for colour-blind separation. `commands.tex` adds `\method`, `\best`, `\second`, `\R`, `\E`, `\argmax`, `\argmin`, theorem environments and the `\TODO` and `\authornote` notes that `\notesfalse` hides.

## Porting a paper

A paper written for Meta FAIR's `fairmeta.cls`, ServiceNow's class or ByteDance Seed's `bytedance_seed.cls` compiles after changing only its `\documentclass` line, since `\checkdata`, `\morelinks`, `\metadata`, `\beginappendix` and `\nm` keep their meaning. The Mem-π arXiv source (2605.21463) builds its 22 pages this way without errors.

## Building

Overleaf's default pdfLaTeX builds `main.tex` as it is, and so does `latexmk -pdf main.tex` locally. XeLaTeX and LuaLaTeX also work. For arXiv, keep the `\pdfoutput=1` line at the top of `main.tex` and upload the generated `main.bbl` with the sources. The class was tested on TeX Live 2026 with the sample in one and two columns, with numbered citations, with an empty front matter, a 25-author list, a three-line title and the usual packages loaded after it.

## Brand assets

`brand/logo-mila.pdf` is the vector wordmark served by mila.quebec in its own purple, and `brand/logo-udem.pdf` is the UdeM signature from the same site recoloured to UdeM blue, the colour umontreal.ca uses. `brand/icon-huggingface.png` is the icon for `\huggingface`.
