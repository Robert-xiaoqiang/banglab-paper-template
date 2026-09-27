# UdeM × Mila arXiv template

`udemmila.cls` typesets arXiv preprints for authors at Université de Montréal and Mila. It takes the front-matter designs of four industry preprint styles (Meta FAIR, ByteDance Seed, ServiceNow and LeapLab) and sets them with the official UdeM and Mila logos, Mila purple and UdeM blue. `main.tex` is a sample paper that doubles as the manual, so compiling it shows every feature.

## Quick start

Copy this project, keep `udemmila.cls` and `assets/` next to your main file, and start from `main.tex`.

```latex
\documentclass[titlestyle=card]{udemmila}   % card | band | rule

\title{Your Title}
\runningtitle{Short Title}                   % header on pages 2 onwards
\author[1,2,*]{First Author}
\author[1,\dagger]{Senior Author}
\affiliation[1]{Mila -- Quebec AI Institute}
\affiliation[2]{Universit\'e de Montr\'eal}
\contribution[*]{Equal contribution}
\contribution[\dagger]{Corresponding author}
\abstract{One paragraph.}
\date{\today}
\correspondence{\email{you@mila.quebec}}
\github{\url{https://github.com/org/repo}}

\begin{document}
\maketitle
...
\bibliographystyle{plainnat}
\bibliography{references}
\beginappendix
...
\end{document}
```

## Title styles

The `titlestyle` option is the only choice that changes how the paper looks at a glance. `card` puts the whole front matter in a tinted card with a purple-to-blue edge and the logos beside the metadata, after Meta FAIR and ServiceNow. `band` runs a full-width purple band with white logos across the top of page one. `rule` puts colour logos in the page-one header over a centred title between purple rules and an outlined abstract, after ByteDance Seed and LeapLab. Everything below the title block is identical across the three.

The other class option is `numbers`, which switches citations from (Author, Year) to [1]. Every `article` option, such as `11pt` or `twocolumn`, passes through.

## Porting a paper from another template

A paper written for Meta FAIR's `fairmeta.cls`, ServiceNow's class or ByteDance Seed's `bytedance_seed.cls` compiles after changing only its `\documentclass` line. The Mem-π arXiv source (2605.21463) was tested this way and builds its 22 pages without errors. `\checkdata`, `\morelinks`, `\metadata`, `\beginappendix` and `\nm` keep their meaning, and author marks can use `\dagger` or `\textdagger`.

## What the class provides

| Piece | Where it comes from |
| --- | --- |
| Inter for the title block, headings, caption labels and running head | closest free match to Mila's TT Norms Pro |
| Latin Modern body and maths, Inconsolata code | matching maths without a font swap |
| Section numbers and caption labels in `milapurple`, citations in `udemblue` | the two brand colours |
| Running head with `\runningtitle` and the UdeM and Mila marks | pages 2 onwards |
| `takeaway` and `promptbox` environments | findings and LLM prompts |
| `\beginappendix` (heading plus appendix contents), `\beginappendix*` (heading only) | Meta FAIR and Seed |
| `\metadata[Key][\faIcon]{Value}` with `\date`, `\correspondence`, `\github`, `\huggingface`, `\projectpage` | Meta FAIR and ServiceNow |

The colours are available to the paper as `milapurple` (`#662E7D`), `udemblue` (`#0057AC`), `umink`, `umgrey`, `umtint` and `umrule`.

## Building

Overleaf's default pdfLaTeX builds `main.tex` as is. Locally, `latexmk -pdf main.tex` does the same, and XeLaTeX and LuaLaTeX also work. For arXiv, upload the `.bbl` file with the sources. The `\pdfoutput=1` line at the top of `main.tex` makes arXiv use pdfLaTeX, which the PDF logos need.

## Brand assets

`assets/logo-mila.pdf` is the vector wordmark served by mila.quebec in its own purple, and `assets/logo-udem.pdf` is the UdeM signature from the same site recoloured to UdeM blue, the colour umontreal.ca uses. The `-white` versions are for the purple band. `assets/logo-huggingface.png` is the icon for `\huggingface`.

## Review folder

`review/template-vote.pdf` compares the four industry templates (A to D) with the three title styles (E to G), two full pages each. It is for choosing the default `titlestyle` and can be deleted once that is settled.
