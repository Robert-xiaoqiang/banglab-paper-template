% banglab.cls -- arXiv preprint class of BangLab, Universite de Montreal and Mila.
%
% The front matter sits in one tinted card that opens with the BangLab wordmark
% and closes with the UdeM and Mila logos. Inter carries the brand (title
% block, headings, caption labels), Latin Modern sets the body and the maths.
% The author, affiliation, abstract and metadata commands keep the names of
% Meta FAIR's fairmeta.cls, so a paper written for that class, or for
% ServiceNow's or ByteDance Seed's, compiles here after changing only
% \documentclass.
%
%   \documentclass{banglab}              % (Author, Year) citations, the default
%   \documentclass[numbers]{banglab}     % [1] citations
%   \documentclass[twocolumn]{banglab}   % any article option passes through
%
% The conventions for papers built on this class are in AGENTS.md.

\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{banglab}[2026/09/28 v1.0 BangLab arXiv preprint]

% Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=BL,prefix=BL@}
\DeclareBoolOption{numbers}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm,
  columnsep=0.65cm, headheight=14pt, headsep=0.7cm, footskip=1.1cm]{geometry}
\@ifclasswith{banglab}{a4paper}{}{\geometry{letterpaper}}
\RequirePackage{etoolbox}
\RequirePackage{parskip}
% Room for long \texttt identifiers before a line is left overfull.
\setlength\emergencystretch{1.5em}

% Fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Latin Modern for body and maths, Inter (the closest free match to TT Norms
% Pro, Mila's own typeface) for the brand, Inconsolata for code. inter.sty
% redefines \rmdefault as well as \sfdefault, so the roman is saved and put back.
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\let\BL@rmdefault\rmdefault
\RequirePackage[scale=0.92, semibold]{inter}
\let\rmdefault\BL@rmdefault
\renewcommand*\familydefault{\rmdefault}
% zi4 has no shapes for the Unicode engines, which get the OpenType files.
\RequirePackage{iftex}
\ifTUTeX
  \RequirePackage{fontspec}
  \setmonofont{Inconsolatazi4-Regular.otf}[BoldFont=Inconsolatazi4-Bold.otf, Scale=0.95]
\else
  \RequirePackage[varqu, varl, scaled=0.95]{zi4}
\fi
\RequirePackage{textcomp}
\RequirePackage{microtype}

% Colours %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loaded with the options papers most often ask for, so a later
% \usepackage[table]{xcolor} or [dvipsnames]{xcolor} raises no option clash.
\RequirePackage[dvipsnames, table]{xcolor}
\definecolor{milapurple}{HTML}{662E7D}  % Mila wordmark, mila.quebec
\definecolor{udemblue}{HTML}{0057AC}    % UdeM signature, umontreal.ca
\definecolor{labink}{HTML}{231A2B}      % title and heading text
\definecolor{labgrey}{HTML}{5F5A66}     % affiliations, metadata, page numbers
\colorlet{labtint}{milapurple!6}        % title card and box background
\colorlet{labrule}{milapurple!30}       % hairlines
% A two-series chart pair checked for lightness, chroma and colour-blind
% separation: the method in purple, a baseline in blue.
\definecolor{chartpurple}{HTML}{7E3F97}
\definecolor{chartblue}{HTML}{5B8FD3}

% Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% amsthm comes before cleveref so theorem references get their names.
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage[most]{tcolorbox}
\RequirePackage{fontawesome5}

% Class-owned files live in brand/ next to the class, whatever \graphicspath says.
\newcommand\BL@asset[1]{brand/#1}

% Citations and links %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Author-year by default, [1] with the numbers option. \citet and \citep work
% in both, so switching the option never needs an edit in the text.
\ifBL@numbers
  \RequirePackage[numbers, sort&compress]{natbib}
\else
  \RequirePackage[round, authoryear]{natbib}
\fi
\renewcommand\bibfont{\small}
\setlength\bibsep{3pt plus 1pt}

\RequirePackage{hyperref}
\hypersetup{colorlinks, linkcolor=milapurple, citecolor=udemblue,
  urlcolor=milapurple, bookmarksnumbered, pdfcreator={LaTeX with banglab.cls}}
\RequirePackage[capitalize, noabbrev, nameinlink]{cleveref}

% Headings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
\titleformat{\section}
  {\sffamily\bfseries\fontsize{14}{17}\selectfont\color{labink}}
  {\color{milapurple}\thesection}{0.7em}{}
\titleformat{\subsection}
  {\sffamily\bfseries\fontsize{11.5}{14}\selectfont\color{labink}}
  {\color{milapurple}\thesubsection}{0.65em}{}
\titleformat{\subsubsection}
  {\sffamily\bfseries\normalsize\color{labink}}
  {\color{milapurple}\thesubsubsection}{0.6em}{}
\titleformat{\paragraph}[runin]
  {\sffamily\bfseries\normalsize\color{labink}}{\theparagraph}{0.6em}{}
\titlespacing*{\section}{0pt}{2.4ex plus .6ex minus .3ex}{0.6ex plus .2ex}
\titlespacing*{\subsection}{0pt}{1.8ex plus .5ex minus .2ex}{0.4ex plus .1ex}
\titlespacing*{\subsubsection}{0pt}{1.4ex plus .4ex minus .2ex}{0.2ex}
\titlespacing*{\paragraph}{0pt}{0.8ex plus .3ex}{0.8em}

% The lab stops at \subsection and uses \paragraph for run-in headings below
% it. \subsubsection still works, with one warning per document.
\let\BL@subsubsection\subsubsection
\newif\ifBL@subsubwarned
\renewcommand\subsubsection{%
  \ifBL@subsubwarned\else
    \ClassWarningNoLine{banglab}{\string\subsubsection\space used. The lab
      convention stops at \string\subsection; use \string\paragraph\space for a
      run-in heading}%
    \global\BL@subsubwarnedtrue
  \fi
  \BL@subsubsection}

\RequirePackage{titletoc}
\titlecontents{section}[1.7em]
  {\addvspace{4pt}\sffamily\bfseries\color{labink}}
  {\contentslabel[\color{milapurple}\thecontentslabel]{1.7em}}{\hspace*{-1.7em}}
  {\hfill\contentspage}
\titlecontents{subsection}[4.1em]
  {\sffamily\small}
  {\contentslabel[\color{milapurple}\thecontentslabel]{2.4em}}{\hspace*{-2.4em}}
  {\titlerule*[0.7pc]{.}\contentspage}

% Captions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "Figure 1" in purple Inter, then the text. A one-line caption is centred, a
% longer one justified, and table captions go above the table.
\RequirePackage{caption}
\RequirePackage{subcaption}
\DeclareCaptionFont{BLlabel}{\sffamily\bfseries\color{milapurple}}
\DeclareCaptionLabelSeparator{BLspace}{\hspace{0.55em}}
\captionsetup{font=small, labelfont=BLlabel, labelsep=BLspace,
  singlelinecheck=true, justification=justified, skip=6pt}
\captionsetup[table]{position=top}
\captionsetup[sub]{font=small, labelfont={sf,bf}, labelformat=parens,
  labelsep=space}

% Front-matter data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Each list accumulates rendered items, with a separator in front of every
% item after the first.
\newcommand\BL@additem[3]{% list, separator, item
  \ifdefempty{#1}{}{\gappto#1{#2}}\gappto#1{#3}}

% Author marks take text or maths symbols: \dagger and \ddagger map to their
% text forms so the marks stay in Inter.
\newcommand\BL@marks[1]{{\sffamily\mdseries\def\dagger{\text{\textdagger}}%
  \def\ddagger{\text{\textdaggerdbl}}#1}}
\newcommand\BL@mark[1]{\ifblank{#1}{}{\textsuperscript{\BL@marks{#1}}}}

\newcommand\BL@title{}
\renewcommand\title[1]{\renewcommand\BL@title{#1}}
\newcommand\BL@reportlabel{Preprint}
\newcommand\reportlabel[1]{\renewcommand\BL@reportlabel{#1}}

% The wordmark is set in type, the first part semibold and the second in
% purple: \lab{Bang}{Lab}. \labname prints it in running text.
\newcommand\BL@labfirst{Bang}
\newcommand\BL@labsecond{Lab}
\newcommand\lab[2]{\renewcommand\BL@labfirst{#1}\renewcommand\BL@labsecond{#2}}
\newcommand\BL@wordmark{{\sffamily\mbox{{\bfseries\color{labink}\BL@labfirst}%
  {\mdseries\color{milapurple}\BL@labsecond}}}}
\newcommand\labname{\BL@wordmark}

% \author[1,2,*]{Name}: names never break across lines, and the plain names
% also go into the PDF metadata.
\newcommand\BL@authors{}
\newcommand\BL@pdfauthors{}
\renewcommand\author[2][]{%
  \BL@additem\BL@authors{, }{\mbox{\def\and{\unskip\egroup, \hbox\bgroup\ignorespaces}#2\BL@mark{#1}}}%
  \BL@additem\BL@pdfauthors{, }{#2}}
\newcommand\BL@affiliations{}
\newcommand\affiliation[2][]{\BL@additem\BL@affiliations{\BL@affilsep}{\BL@mark{#1}#2}}
\newcommand\BL@affilsep{\hspace{0.9em plus 0.3em}\allowbreak}
\newcommand\BL@contributions{}
\newcommand\contribution[2][]{\BL@additem\BL@contributions{\BL@affilsep}{\BL@mark{#1}#2}}

% The abstract works as a command in the preamble, \abstract{...}, and as the
% usual environment before \maketitle. One that arrives after \maketitle is
% printed where it stands, with a warning. The environment's body is stored in
% a macro, so it cannot hold \verb or a # or % inside a link; the file form,
% \abstract{\input{sections/abstract}}, reads the file only when printing.
\newif\ifBL@titledone
\newcommand\BL@abstract{}
\RequirePackage{environ}
\def\BL@abstractenv{abstract}
\renewcommand\abstract{\ifx\@currenvir\BL@abstractenv
    \expandafter\Collect@Body\expandafter\BL@setabstract
  \else\expandafter\BL@setabstract\fi}
\let\endabstract\relax
\newcommand\BL@setabstract[1]{%
  \ifBL@titledone
    \ClassWarning{banglab}{The abstract comes after \string\maketitle\space and
      is printed where it stands. Move it before \string\maketitle\space to put
      it in the title card}%
    \par{\sffamily\bfseries\small\color{milapurple}Abstract\par}\vspace{1mm}#1\par
  \else
    \gdef\BL@abstract{#1}%
  \fi}

% \teaser{figure}{caption}: an optional full-width figure under the card.
\newcommand\BL@teaser{}
\newcommand\BL@teasercaption{}
\newcommand\teaser[2]{\renewcommand\BL@teaser{#1}\renewcommand\BL@teasercaption{#2}}

% Metadata lines: \metadata[Key]{Value}, or with an icon,
% \metadata[Key][\faBook]{Value}. The named commands below are shortcuts.
\newcommand\BL@metadata{}
\NewDocumentCommand\metadata{O{} O{\faAngleRight} m}{%
  \BL@additem\BL@metadata{\par}{\BL@metaitem{#2}{#1}{#3}}}
\newcommand\BL@metaitem[3]{% icon, key, value; wrapped lines hang under the key
  \hangindent=1.25em\hangafter=1\relax
  \mbox{\makebox[1.25em][l]{\color{milapurple}#1}%
  \ifblank{#2}{}{{\bfseries\color{labink}#2:}\ }}{\color{labgrey}#3}}

\newcommand\email[1]{\href{mailto:#1}{\nolinkurl{#1}}}
\renewcommand\date[1]{\ifblank{#1}{}{\metadata[Date][\faCalendar*]{#1}}}
\newcommand\correspondence[1]{\metadata[Correspondence][\faEnvelope[regular]]{#1}}
\newcommand\github[1]{\metadata[Code][\faGithub]{#1}}
\newcommand\huggingface[1]{\metadata[Hugging Face][\raisebox{-0.15em}{%
  \includegraphics[height=1em]{\BL@asset{icon-huggingface.png}}}]{#1}}
\newcommand\projectpage[1]{\metadata[Project page][\faGlobe]{#1}}
\newcommand\blogpost[1]{\metadata[Blog][\faPenNib]{#1}}

% Aliases so papers written for fairmeta, servicenow or bytedance_seed port by
% changing only \documentclass.
\NewCommandCopy\checkdata\metadata
\newcommand\morelinks[1]{\metadata[More links][\faLink]{#1}}
\providecommand\nm[1]{#1}

% Title card %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\BL@spaced[1]{\textls[110]{\MakeUppercase{#1}}}
\newcommand\BL@nohyphens{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}

% UdeM and Mila side by side, divided by a hairline; #1 is the logo height.
\newcommand\BL@lockup[1]{%
  \mbox{\includegraphics[height=1.18\dimexpr#1\relax]{\BL@asset{logo-udem.pdf}}%
  \hspace{0.55\dimexpr#1\relax}%
  {\color{labrule}\rule[-0.02\dimexpr#1\relax]{0.5pt}{1.04\dimexpr#1\relax}}%
  \hspace{0.55\dimexpr#1\relax}%
  \includegraphics[height=#1]{\BL@asset{logo-mila.pdf}}}}

% "BangLab | TECHNICAL REPORT" at the top of the card.
\newcommand\BL@labline{%
  {\fontsize{11}{13}\selectfont\BL@wordmark}%
  \ifdefempty\BL@reportlabel{}{\hspace{0.7em}%
    {\color{labrule}\rule[-0.2em]{0.5pt}{1.05em}}\hspace{0.7em}%
    {\sffamily\bfseries\scriptsize\color{labgrey}\BL@spaced{\BL@reportlabel}}}\par}

\newsavebox\BL@lockupbox
\newcommand\BL@card{%
  \sbox\BL@lockupbox{\BL@lockup{7.2mm}}%
  \begin{tcolorbox}[enhanced, frame hidden, arc=9pt, boxrule=0pt, colback=labtint,
      left=0.75cm, right=0.75cm, top=0.6cm, bottom=0.6cm,
      before skip=0pt, after skip=0pt]
    \setlength\parskip{0pt}\setlength\parindent{0pt}%
    {\raggedright
      \BL@labline
      \vspace{4mm}%
      {\BL@nohyphens\sffamily\bfseries\fontsize{20.5}{25.5}\selectfont
        \color{labink}\BL@title\par}%
      \ifdefempty\BL@authors{}{\vspace{3.5mm}{\sffamily\bfseries
        \fontsize{10.5}{15}\selectfont\color{labink}\BL@authors\par}}%
      \ifdefempty\BL@affiliations{}{\vspace{1.4mm}{\sffamily
        \fontsize{9}{12.5}\selectfont\color{labgrey}\BL@affiliations\par}}%
      \ifdefempty\BL@contributions{}{\vspace{0.8mm}{\sffamily
        \fontsize{8}{11}\selectfont\color{labgrey}\BL@contributions\par}}%
      \par}%
    \ifdefempty\BL@abstract{}{\vspace{5mm}%
      {\normalsize\setlength\parskip{0.5\baselineskip plus 2pt}\color{labink!90}\BL@abstract\par}}%
    \vspace{5mm}%
    \begin{minipage}[b]{\dimexpr\linewidth-\wd\BL@lockupbox-0.6cm\relax}
      \ifdefempty\BL@metadata{}{{\raggedright\sffamily\fontsize{8.5}{12.5}\selectfont
        \BL@metadata\par}}%
    \end{minipage}\hfill\usebox\BL@lockupbox
  \end{tcolorbox}}

\newcommand\BL@printteaser{\ifdefempty\BL@teaser{}{%
  \vspace{5mm}{\captionsetup{type=figure}{\centering\BL@teaser\par}\vspace{1mm}%
  \caption{\BL@teasercaption}}}}

\renewcommand\maketitle{\begingroup\let\@footnotemark\H@@footnotemark\let\@footnotetext\H@@footnotetext\BL@maketitle\endgroup
  \global\BL@titledonetrue\global\let\maketitle\relax}
\newcommand\BL@maketitle{%
  \ifx\@pdftitle\@empty\hypersetup{pdftitle={\BL@title}}\fi
  \ifx\@pdfauthor\@empty\hypersetup{pdfauthor={\BL@pdfauthors}}\fi
  \thispagestyle{BLplain}%
  \if@twocolumn
    \twocolumn[{\setlength\parskip{0pt}\BL@card\BL@printteaser}\vspace{7mm}]%
  \else
    {\setlength\parskip{0pt}\BL@card\BL@printteaser\par}\vspace{6mm}%
  \fi
  % No float may sit above the title card, as in article's own \maketitle.
  \@thanks\global\let\@thanks\@empty
  \suppressfloats[t]%
}

\AtBeginDocument{%
  \pdfstringdefDisableCommands{\def\\{ }\let\texttt\@firstofone
    \let\thanks\@gobble\def\and{,}}}

% Page style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The wordmark and logos appear on page one only; every page carries just a
% page number.
\RequirePackage{fancyhdr}
\fancypagestyle{BLplain}{%
  \fancyhf{}\renewcommand\headrulewidth{0pt}\renewcommand\footrulewidth{0pt}%
  \fancyfoot[C]{{\sffamily\footnotesize\color{labgrey}\thepage}}}
\pagestyle{BLplain}
\renewcommand\footnoterule{{\color{labrule}\kern-3pt\hrule\@width 3cm\kern 2.6pt}}

% Appendix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \beginappendix starts a new page with an "Appendix" heading and a contents
% list of the appendix sections; \beginappendix* leaves the list out.
\NewDocumentCommand\beginappendix{s}{%
  \clearpage\appendix
  {\sffamily\bfseries\fontsize{20}{24}\selectfont\color{labink}Appendix\par}%
  \vspace{1.5mm}{\color{milapurple}\rule{\linewidth}{0.6pt}}\par\vspace{2mm}%
  \IfBooleanF{#1}{%
    \startcontents[appendix]%
    \printcontents[appendix]{}{1}[2]{}%
    \vspace{4mm}}}

% Boxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \begin{takeaway}[Title] ... \end{takeaway}: a finding the reader should keep.
\newtcolorbox{takeaway}[1][Takeaway]{enhanced, breakable, arc=5pt,
  frame hidden, boxrule=0pt, colback=labtint,
  left=11pt, right=11pt, top=7pt, bottom=7pt, before skip=8pt, after skip=8pt,
  before upper={{\sffamily\bfseries\small\color{milapurple}#1\par}\vspace{2pt}}}

% \begin{promptbox}[Title] ... \end{promptbox}: a prompt or model output in
% Inconsolata; verbatim content is allowed inside.
\newtcolorbox{promptbox}[1][Prompt]{enhanced, breakable, arc=4pt,
  boxrule=0.6pt, colframe=milapurple!55, colback=black!2,
  colbacktitle=milapurple!10, coltitle=labink,
  fonttitle=\sffamily\bfseries\footnotesize, title={#1},
  fontupper=\ttfamily\footnotesize, left=8pt, right=8pt, top=5pt, bottom=5pt,
  before skip=8pt, after skip=8pt}

\endinput
