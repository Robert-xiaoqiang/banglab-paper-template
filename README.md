# UdeM × Mila arXiv template

`udemmila.cls` typesets arXiv preprints for BangLab and other authors at Université de Montréal and Mila. It takes the front-matter designs of four industry preprint styles (Meta FAIR, ByteDance Seed, ServiceNow and LeapLab) and sets them with the official UdeM and Mila logos, Mila purple, UdeM blue and the BangLab wordmark. `main.tex` is a sample paper that doubles as the manual, so compiling it shows every feature.

## Quick start

Copy this project, keep `udemmila.cls` and `assets/` next to your main file, and start from `main.tex`.

```latex
\documentclass[titlestyle=card]{udemmila}   % one of the sixteen styles below

\title{Your Title}
\lab{Bang}{Lab}                              % wordmark for the lab styles
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

The `titlestyle` option is the only choice that changes how the paper looks at a glance. `card` puts the whole front matter in a tinted card with a purple-to-blue edge and the logos beside the metadata, after Meta FAIR and ServiceNow. `band` runs a full-width purple band with white logos across the top of page one. `rule` puts colour logos in the page-one header over a centred title between purple rules and an outlined abstract, after ByteDance Seed and LeapLab. The three lab styles carry the BangLab wordmark and draw no coloured edge bar anywhere. `labcard` is the card without its edge, with the wordmark opening the card. `labband` sets the wordmark in white on a solid purple band and puts the abstract and links in one tinted panel. `masthead` is an editorial first page with no boxes, the wordmark and logos above a double rule and the abstract set as text. They also put the wordmark in the running head and draw the takeaway box without its left rule.

Ten more lab styles came from a survey of twenty industry reports (Qwen, Kimi, MiMo, GLM, JD.com, DeepSeek, MiniMax, Gemma, Hunyuan, InternVL, LongCat, Phi, OLMo, Nemotron, Apple, Keye, Ling, Magistral, Step and SmolLM). `cover` makes page one a full purple cover. `hero` holds the title in a deep aubergine block from the top edge. `teaser` sets the title between a heavy and a light rule and prints the `\teaser` figure on page one. `split` stacks authors and links in a left column. `swiss` uses an oversized title over a three-column grid and sets the whole paper in Inter. `highlights` puts the abstract beside the `\highlight` numbers. `letterhead` is a report series with `\reportnumber`, a small-capitals title and serif headings. `bilingual` sets the abstract beside its French résumé from `\frenchabstract`. `motif` draws a pale network after the Mila glyph in the corner. `minimal` is the plain Qwen and DeepSeek page with `\copyrightnote`. Appendix B of `main.tex` has the full table. Everything below the title block is identical across all sixteen styles, except that `swiss` sets the body in Inter and `letterhead` sets the headings in the serif.

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
| `\lab{Bang}{Lab}`, `\labdescriptor{...}`, and `\labname` for the wordmark in running text | the lab styles |
| `\teaser{figure}{caption}`, `\highlight{56.7}{label}`, `\reportnumber`, `\copyrightnote`, `\frenchabstract`, `\frenchreportlabel` | printed only by the styles built around them |

The colours are available to the paper as `milapurple` (`#662E7D`), `udemblue` (`#0057AC`), `umink`, `umgrey`, `umtint` and `umrule`. For two-series charts, `chartpurple` (`#7E3F97`, the method) and `chartblue` (`#5B8FD3`, a baseline) pass lightness, chroma and colour-blind separation checks, and the teaser chart in `main.tex` uses them.

## Building

Overleaf's default pdfLaTeX builds `main.tex` as is. Locally, `latexmk -pdf main.tex` does the same, and XeLaTeX and LuaLaTeX also work. For arXiv, upload the `.bbl` file with the sources. The `\pdfoutput=1` line at the top of `main.tex` makes arXiv use pdfLaTeX, which the PDF logos need.

## Brand assets

`assets/logo-mila.pdf` is the vector wordmark served by mila.quebec in its own purple, and `assets/logo-udem.pdf` is the UdeM signature from the same site recoloured to UdeM blue, the colour umontreal.ca uses. The `-white` versions are for the purple band. `assets/logo-huggingface.png` is the icon for `\huggingface`.

## Review folder

`review/template-vote.pdf` is the third-round vote sheet: the two first-round styles that were kept (E `card`, F `band`), the three round-two lab styles (H `labcard`, I `labband`, J `masthead`) and the ten new ones (K to T), two full pages each. The same fifteen, with the twenty-four industry reports they drew on, are on the preview site at https://claude.ai/artifact/KNvaacerFRRXtW3pdt9YLJ. The folder is for choosing the default `titlestyle` and can be deleted once that is settled.
