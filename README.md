# BangLab paper template

`banglab.cls` typesets arXiv preprints for BangLab at Université de Montréal and Mila. The front matter sits in one tinted card that opens with the BangLab wordmark and closes with the logos the paper names, and the wordmark and logos appear on page one only. Headings, caption labels and the title block are set in Inter, the closest free match to Mila's typeface, over an 11pt XCharter body. The sample paper in this project doubles as the manual.

## Quick start

Start a paper with `./banglab init` (see Using the template in a paper below), then edit `main.tex`, which holds the front matter and the text.

```latex
\documentclass{banglab}          % [numbers] for [1] citations, [10pt] or [12pt], [twocolumn]
\input{commands}

\title{Your Title}
\author[1,2,*]{First Author}
\author[1,2,\dagger]{Senior Author}
\affiliation[1]{Mila -- Quebec AI Institute}
\affiliation[2]{Universit\'e de Montr\'eal}
\contribution[*]{Equal contribution}
\contribution[\dagger]{Corresponding author}
\logos{\includegraphics{assets/logo-udem.pdf}\includegraphics{assets/logo-mila.pdf}}
\abstract{One paragraph.}
\date{\today}
\correspondence{\email{you@mila.quebec}}
\github{\href{https://github.com/org/repo}{github.com/org/repo}}
```

## Layout

```
                  library: owned by the template, replaced by ./banglab update
banglab.cls       the class
assets/           the logo library
AGENTS.md         writing and LaTeX conventions, for people and agents
banglab.lock      in a paper only: its release and the hash of every library file

                  scaffold: copied once by ./banglab init, then the paper's own
main.tex          class options, front matter and the whole text
commands.tex      packages and macros this paper adds
references.bib    the bibliography
figures/          drawings only (TikZ, pgfplots or PDF), captions stay in main.tex
tables/           tabular bodies only, captions stay in main.tex
CLAUDE.md         points Claude Code at AGENTS.md

                  template only, never copied into a paper
banglab           the tool that starts and updates papers
banglab-arxiv     the arXiv zip builder behind ./banglab arxiv
banglab-files.txt which files are library and which are scaffold
CHANGELOG.md      what each release changed
README.md         this file
```

A label repeats the file it points to, so `figures/overview.tex` is `\label{fig:overview}` and `tables/main-results.tex` is `\label{tab:main-results}`. `AGENTS.md` has the rest: label prefixes, `\citet` against `~\citep`, headings down to `\subsection`, and the table and figure rules.

## Using the template in a paper

The template is a versioned library, not a folder to copy. A paper keeps an unedited copy of the library files and records their release in `banglab.lock`, so a fix in the template reaches every paper by one command, and nobody has to remember which paper runs which class. The one rule that makes this work is that **a paper never edits a library file**. It changes what they do from its own `commands.tex` (`\renewcommand`, `\definelogo`, `\hypersetup`), and anything that needs more than that goes into the template as a release.

The template's source of truth is its GitHub repository, branch `master`, which holds the release tags `./banglab` reads, so run the tool from a clone of that repository. The template's Overleaf project is a mirror of `master`, pushed through Overleaf's git bridge for colleagues who only use Overleaf. That bridge keeps a single branch, which Overleaf names `main`, and no tags, so it cannot be the source of truth. Edit the template in a clone, never in its Overleaf project.

A paper needs no GitHub repository. It lives in its own Overleaf project and is edited locally through a git clone of that project (Overleaf, Menu → Git gives the URL). Its `banglab.lock` records the release it runs, so the tags are needed only where the tool runs.

| Step | Command |
| --- | --- |
| Start a paper | Create a blank Overleaf project and clone it with its git URL. Run `./banglab init <clone> --force`, which replaces the blank project's stub `main.tex`, then `git push` in the clone. `--no-commit` leaves the files uncommitted. |
| See where papers stand | `./banglab status <paper>...` prints each paper's release, how many releases it is behind, and any library file someone edited. |
| Update a paper | First `git pull` in the paper's clone, so the co-authors' Overleaf edits are in it. `./banglab update <paper>` then prints the changelog since the paper's release, warns on a layout-changing one, builds the paper before and after, replaces the library files and commits. Once the build looks right, `git push`, and the change appears in Overleaf. `--version vX.Y.Z` picks a release other than the newest, and `--no-commit` leaves the files uncommitted. |
| Build the arXiv zip | `./banglab arxiv <paper>` compiles the paper, ships exactly the files the compile read plus `main.bbl`, runs arXiv's file check over them, compiles the zip again from scratch, and writes `<paper>/arxiv_submission.zip` only when everything passed. Install arXiv's own checker once with `./banglab arxiv --setup-preflight`. `--out <zip>` changes the destination, `--keep` leaves the scratch tree for inspection, and `--no-preflight` skips arXiv's parser. Upload with TeX Live 2025, arXiv's default. |

Releases that do not change the layout can go into a paper at any time. A layout-changing release moves text, so take it in a draft, not in the last two weeks before a deadline and not after an arXiv version is out.

`init` and `update` commit in the paper's clone and never push, so a paper's Overleaf project changes only when you push.

## Releasing a template change

A maintainer's clone has two remotes: `origin`, the GitHub repository, and `overleaf-mirror`, the template's Overleaf project. The mirror maps `master` to Overleaf's `main`, never takes a tag, and has its push URL disabled, so routine pushes reach GitHub only and the Overleaf copy is updated only when someone decides it should be:

```
git clone git@github.com:Robert-xiaoqiang/banglab-paper-template.git
git remote add overleaf-mirror https://git@git.overleaf.com/6ab8b19e2cf029892db9ea89
git config remote.overleaf-mirror.push refs/heads/master:refs/heads/main
git config remote.overleaf-mirror.tagOpt --no-tags
git remote set-url --push overleaf-mirror no-push-until-asked
```

1. Edit the library files, and bump the version in `\ProvidesClass`.
2. Build the sample in TeX Live 2025 and 2026 until it has no errors, warnings or bad boxes.
3. Add an entry to `CHANGELOG.md`, marked layout-changing when text moves on the page.
4. Commit, tag the release (`git tag v1.1.0`) and push both to GitHub with `git push origin master v1.1.0`. When the Overleaf copy should catch up, push it once by URL, `git push https://git@git.overleaf.com/6ab8b19e2cf029892db9ea89 master:main`, which leaves the disabled push URL in place.
5. Run `./banglab status` over the lab's papers to see which ones to update.

## Typesetting

The body settings follow the class that Google DeepMind's reports use, which DeepSeek, MiniMax, Xiaomi and NVIDIA copied for their own report classes. Of the twenty-four reports measured for this template, those five set 11pt, four of them in XCharter. The NeurIPS-derived templates (Kimi, GLM, InternVL and others) set 10pt Times and the Meta-derived ones 10pt Computer Modern, both over lines of 95 to 118 characters.

| Setting | Value |
| --- | --- |
| Body and maths | XCharter 11pt with `newtxmath`, 13.6pt leading (10pt and 12pt are class options) |
| Brand elements | Inter, the title block, headings, caption labels and page numbers |
| Code | Inconsolata, scaled to Charter's x-height |
| Page | US Letter, 2.5 cm margins, a 16.6 cm line of about 95 characters |
| Paragraphs | No indent, half a line between paragraphs |
| Page breaks | No single line of a paragraph left alone at the head or foot of a page, and a takeaway box never split |
| Headings | Inter, ragged-right, on LaTeX's standard size steps so any maths font scales with them |
| Floats | May fill 85% of a text page, so figure-heavy reports get fewer float-only pages |

## Citations

Author-year is the default. `\documentclass[numbers]{banglab}` switches to numbered citations, and `\citet` and `\citep` need no change in the text. Keep `\bibliographystyle{plainnat}` in both modes, or use `unsrtnat` to number references in order of first citation.

## What the class provides

| Command or environment | Use |
| --- | --- |
| `\author[marks]{Name}`, `\affiliation[mark]{...}`, `\contribution[mark]{...}` | Authors with affiliation and contribution marks, where `\dagger` also works as a mark |
| `\abstract{...}`, or `\begin{abstract}...\end{abstract}` before `\maketitle` | The abstract inside the card. It cannot hold `\verb` or a `#` or `%` inside a link |
| `\date`, `\correspondence`, `\github`, `\huggingface`, `\projectpage`, `\blogpost`, `\metadata[Key][\faIcon]{Value}` | Metadata lines with icons |
| `\logos{\includegraphics{assets/logo-udem.pdf}\includegraphics{assets/logo-mila.pdf}}` | The logos in the card and their order, one `\includegraphics` with its literal path per logo; `\logos{}` for none |
| `\definelogo{name}{path}{scale}` | Registers a logo's height as a multiple of the row, keyed by the path written in `\includegraphics`; a paper's own logo goes under `figures/` |
| `\teaser{figure}{caption}` | An optional full-width figure under the card |
| `\labname` | The BangLab wordmark in running text |
| `takeaway`, `promptbox` | A tinted box for a finding, and a box for prompts or model outputs |
| `\beginappendix`, `\beginappendix*` | The appendix heading with, or without, a contents list |

The colours `milapurple` (`#662E7D`), `udemblue` (`#0057AC`), `labink`, `labgrey`, `labtint` and `labrule` are available to the paper, and `chartpurple` with `chartblue` is a two-series pair checked for colour-blind separation. `commands.tex` adds `\method`, `\R`, `\E`, `\argmax`, `\argmin` and the theorem environments, and the class provides `\best`, `\second` and the `\TODO` and `\authornote` notes that `\notesfalse` hides.

## Porting a paper

A paper written for Meta FAIR's `fairmeta.cls`, ServiceNow's class or ByteDance Seed's `bytedance_seed.cls` compiles after changing only its `\documentclass` line, since `\checkdata`, `\morelinks`, `\metadata`, `\beginappendix` and `\nm` keep their meaning. The Mem-π arXiv source (2605.21463) builds its 22 pages this way without errors.

## Building

Overleaf's default pdfLaTeX builds `main.tex` as it is, and so does `latexmk -pdf main.tex` locally. XeLaTeX and LuaLaTeX also work. For arXiv, run `./banglab arxiv <paper>` from a clone of this repository: it builds the paper, stages exactly the files the compile read plus `main.bbl`, runs arXiv's own file check (the one that deletes files no `.tex` names), compiles the zip again in an empty directory, and writes the zip only when every check passed. Keep the `\pdfoutput=1` line at the top of `main.tex`, and choose TeX Live 2025 at upload, arXiv's default. The class is tested on TeX Live 2025 and 2026 with the sample in one and two columns, with numbered citations, with an empty front matter, a 25-author list, a three-line title and the usual packages loaded after it.

## Logos

`\logos{...}` in the preamble lists the logos the card shows, in order, each as `\includegraphics{<path>}` with the path exactly as this table writes it. The paths are written out, rather than picked by name, because arXiv keeps a graphics file only when a `.tex` file of the paper names it, and a file the class alone referred to is deleted as unused at upload (that is what happened to the first two papers on this template). Show only the logos of the institutions the authors belong to, since every one of them is a trademark.

| Path | Institution | Source |
| --- | --- | --- |
| `assets/logo-udem.pdf` | Université de Montréal | mila.quebec, recoloured to UdeM blue `#0057AC` |
| `assets/logo-mila.pdf` | Mila | mila.quebec, in its own purple `#662E7D` |
| `assets/logo-mcgill.pdf` | McGill University | mila.quebec, recoloured to McGill red `#ED1B2F` |
| `assets/logo-polytechnique.png` | Polytechnique Montréal | Wikimedia Commons, CC0 (a 2400 px PNG, the only raster logo) |
| `assets/logo-hec.pdf` | HEC Montréal | Wikimedia Commons, public domain |
| `assets/logo-cifar.pdf` | CIFAR | mila.quebec, recoloured to near-black |
| `assets/logo-ibm.pdf` | IBM | Wikimedia Commons, public domain |
| `assets/logo-qwen.pdf` | Qwen, Alibaba | Wikimedia Commons, Apache 2.0 |
| `assets/logo-alibabacloud.pdf` | Alibaba Cloud | Wikimedia Commons, public domain |
| `assets/logo-servicenow.pdf` | ServiceNow | Wikimedia Commons, public domain |
| `assets/logo-microsoft.pdf` | Microsoft | Wikimedia Commons, public domain |
| `assets/logo-nvidia.pdf` | NVIDIA | Wikimedia Commons, Apache 2.0 |
| `assets/logo-deepmind.pdf` | Google DeepMind | Wikimedia Commons, public domain |

Every file is cropped to its content, and the class registers each path's height so a two-line signature and a one-line wordmark read at the same weight. When the chosen logos take more than half the card, they move to their own row under the metadata. A logo that is not in the library goes under `figures/` and is registered in `commands.tex` with `\definelogo{name}{figures/logo-name.pdf}{scale}`. The Hugging Face mark beside `\huggingface` is drawn by the class, so no icon file ships with a paper.
