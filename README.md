# BangLab paper template

`banglab.cls` typesets arXiv preprints for BangLab at Université de Montréal and Mila. The front matter sits in one tinted card that opens with the BangLab wordmark and closes with the UdeM and Mila logos, and the wordmark and logos appear on page one only. Headings, caption labels and the title block are set in Inter, the closest free match to Mila's typeface, over a Latin Modern body. The sample paper in this project doubles as the manual.

## Quick start

Copy the project (on Overleaf, Menu → Copy Project), then edit `main.tex`, which holds the front matter and the text.

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
\abstract{One paragraph.}
\date{\today}
\correspondence{\email{you@mila.quebec}}
\github{\href{https://github.com/org/repo}{github.com/org/repo}}
```

## Layout

```
main.tex          class options, front matter and the whole text
banglab.cls       the class, not edited per paper
assets/           the logo library and icons the class draws
commands.tex      packages and macros this paper adds
references.bib    the bibliography
figures/          drawings only (TikZ, pgfplots or PDF), captions stay in main.tex
tables/           tabular bodies only, captions stay in main.tex
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
| `\abstract{...}`, or `\begin{abstract}...\end{abstract}` before `\maketitle` | The abstract inside the card. It cannot hold `\verb` or a `#` or `%` inside a link |
| `\date`, `\correspondence`, `\github`, `\huggingface`, `\projectpage`, `\blogpost`, `\metadata[Key][\faIcon]{Value}` | Metadata lines with icons |
| `\reportlabel{...}` | The label beside the wordmark, Preprint by default |
| `\logos{udem,mila,mcgill}` | The logos in the card and their order, `udem,mila` by default |
| `\definelogo{name}{file}{scale}` | Adds a logo from `assets/`, with its height as a multiple of the row |
| `\teaser{figure}{caption}` | An optional full-width figure under the card |
| `\labname` | The BangLab wordmark in running text |
| `takeaway`, `promptbox` | A tinted box for a finding, and a box for prompts or model outputs |
| `\beginappendix`, `\beginappendix*` | The appendix heading with, or without, a contents list |

The colours `milapurple` (`#662E7D`), `udemblue` (`#0057AC`), `labink`, `labgrey`, `labtint` and `labrule` are available to the paper, and `chartpurple` with `chartblue` is a two-series pair checked for colour-blind separation. `commands.tex` adds `\method`, `\best`, `\second`, `\R`, `\E`, `\argmax`, `\argmin`, theorem environments and the `\TODO` and `\authornote` notes that `\notesfalse` hides.

## Porting a paper

A paper written for Meta FAIR's `fairmeta.cls`, ServiceNow's class or ByteDance Seed's `bytedance_seed.cls` compiles after changing only its `\documentclass` line, since `\checkdata`, `\morelinks`, `\metadata`, `\beginappendix` and `\nm` keep their meaning. The Mem-π arXiv source (2605.21463) builds its 22 pages this way without errors.

## Building

Overleaf's default pdfLaTeX builds `main.tex` as it is, and so does `latexmk -pdf main.tex` locally. XeLaTeX and LuaLaTeX also work. For arXiv, keep the `\pdfoutput=1` line at the top of `main.tex` and upload the generated `main.bbl` with the sources. The class was tested on TeX Live 2026 with the sample in one and two columns, with numbered citations, with an empty front matter, a 25-author list, a three-line title and the usual packages loaded after it.

## Logos

`\logos{...}` takes any of these names, in the order the card should show them. Show only the logos of the institutions the authors belong to, since every one of them is a trademark.

| Name | Institution | Source |
| --- | --- | --- |
| `udem` | Université de Montréal | mila.quebec, recoloured to UdeM blue `#0057AC` |
| `mila` | Mila | mila.quebec, in its own purple `#662E7D` |
| `mcgill` | McGill University | mila.quebec, recoloured to McGill red `#ED1B2F` |
| `polytechnique` | Polytechnique Montréal | Wikimedia Commons, CC0 (a 2400 px PNG, the only raster logo) |
| `hec` | HEC Montréal | Wikimedia Commons, public domain |
| `cifar` | CIFAR | mila.quebec, recoloured to near-black |
| `ibm` | IBM | Wikimedia Commons, public domain |
| `qwen` | Qwen, Alibaba | Wikimedia Commons, Apache 2.0 |
| `alibabacloud` | Alibaba Cloud | Wikimedia Commons, public domain |
| `servicenow` | ServiceNow | Wikimedia Commons, public domain |
| `microsoft` | Microsoft | Wikimedia Commons, public domain |
| `nvidia` | NVIDIA | Wikimedia Commons, Apache 2.0 |
| `deepmind` | Google DeepMind | Wikimedia Commons, public domain |

Every file is cropped to its content, and `\definelogo` sets its height so a two-line signature and a one-line wordmark read at the same weight. When the chosen logos take more than half the card, they move to their own row under the metadata. `assets/icon-huggingface.png` is the icon for `\huggingface`.
