% udemmila.cls -- arXiv preprint class for Universite de Montreal and Mila.
%
% Distilled from four industry arXiv styles: the title card and author API of
% Meta FAIR's fairmeta.cls, the logo header and ruled title of ByteDance
% Seed's bytedance_seed.cls, the link metadata of ServiceNow's class, and the
% grey abstract panel of LeapLab's leaplab.sty. The author, affiliation,
% abstract and metadata commands keep the fairmeta/servicenow/seed names, so a
% paper written for one of those classes compiles here after changing only
% \documentclass.
%
%   \documentclass[titlestyle=card]{udemmila}   % card | band | rule
%                                              % labcard | labband | masthead
%                                              % cover | hero | teaser | split | swiss
%                                              % highlights | letterhead | bilingual
%                                              % motif | minimal
%   \documentclass[numbers]{udemmila}           % [1] citations instead of (Author, Year)
%   \documentclass[twocolumn]{udemmila}         % any article option passes through

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{udemmila}[2026/09/27 v1.0 UdeM x Mila arXiv preprint]

% Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=UM,prefix=UM@}
\DeclareStringOption[card]{titlestyle}
\DeclareBoolOption{numbers}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\LoadClass{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[letterpaper, top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm,
  columnsep=0.65cm, headheight=14pt, headsep=0.7cm, footskip=1.1cm]{geometry}
\RequirePackage{etoolbox}
\RequirePackage{parskip}

% Every style except the first three (card, band, rule) is a lab style: it
% carries the lab wordmark and uses no coloured edge bars anywhere, including
% the takeaway box. card, band and rule keep their original look.
\newif\ifUM@labstyle
\UM@labstyletrue
\ifdefstring\UM@titlestyle{card}{\UM@labstylefalse}{}
\ifdefstring\UM@titlestyle{band}{\UM@labstylefalse}{}
\ifdefstring\UM@titlestyle{rule}{\UM@labstylefalse}{}
% Room for long \texttt identifiers before a line is left overfull.
\setlength\emergencystretch{1.5em}

% Fonts: Latin Modern body and math, Inter for everything that carries the
% brand (title block, headings, caption labels, headers), Inconsolata for code.
% Inter is the closest free match to TT Norms Pro, Mila's own typeface.

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
% inter.sty redefines \rmdefault as well as \sfdefault, so the Latin Modern
% roman is saved first and put back.
\let\UM@rmdefault\rmdefault
\RequirePackage[scale=0.92, semibold]{inter}
\let\rmdefault\UM@rmdefault
\renewcommand*\familydefault{\rmdefault}
\RequirePackage[varqu, varl, scaled=0.95]{zi4}
\RequirePackage{textcomp}
\RequirePackage{microtype}

% Colours %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loaded with the two options papers most often ask for, so a later
% \usepackage[table]{xcolor} does not raise an option clash.
\RequirePackage[dvipsnames, table]{xcolor}

\definecolor{milapurple}{HTML}{662E7D}  % Mila wordmark, mila.quebec
\definecolor{udemblue}{HTML}{0057AC}    % UdeM signature, umontreal.ca
\definecolor{umink}{HTML}{231A2B}       % title and heading text
\definecolor{umgrey}{HTML}{5F5A66}      % affiliations, metadata, running head
\colorlet{umtint}{milapurple!6}         % title card and box background
\colorlet{umrule}{milapurple!30}        % hairlines
\definecolor{umnight}{HTML}{2E1A3B}     % deep ground of the hero style
% A two-series chart pair from the same two hues, checked for lightness,
% chroma and colour-blind separation: the method in purple, a baseline in blue.
\definecolor{chartpurple}{HTML}{7E3F97}
\definecolor{chartblue}{HTML}{5B8FD3}

% Graphics, tables, maths %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[most]{tcolorbox}
\RequirePackage{eso-pic}
\RequirePackage{fontawesome5}

% Class-owned assets live next to the class, whatever \graphicspath says.
\newcommand\UM@asset[1]{assets/#1}

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifUM@numbers
  \RequirePackage[numbers, sort&compress]{natbib}
\else
  \RequirePackage[round, authoryear]{natbib}
\fi
\renewcommand\bibfont{\small}
\setlength\bibsep{3pt plus 1pt}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  linkcolor=milapurple,
  citecolor=udemblue,
  urlcolor=milapurple,
  pdfcreator={LaTeX with udemmila.cls},
}
\RequirePackage[capitalize, noabbrev, nameinlink]{cleveref}

% Headings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
\titleformat{\section}
  {\sffamily\bfseries\fontsize{14}{17}\selectfont\color{umink}}
  {\color{milapurple}\thesection}{0.7em}{}
\titleformat{\subsection}
  {\sffamily\bfseries\fontsize{11.5}{14}\selectfont\color{umink}}
  {\color{milapurple}\thesubsection}{0.65em}{}
\titleformat{\subsubsection}
  {\sffamily\bfseries\normalsize\color{umink}}
  {\color{milapurple}\thesubsubsection}{0.6em}{}
\titleformat{\paragraph}[runin]
  {\sffamily\bfseries\normalsize\color{umink}}{\theparagraph}{0.6em}{}
\titlespacing*{\section}{0pt}{2.4ex plus .6ex minus .3ex}{0.6ex plus .2ex}
\titlespacing*{\subsection}{0pt}{1.8ex plus .5ex minus .2ex}{0.4ex plus .1ex}
\titlespacing*{\subsubsection}{0pt}{1.4ex plus .4ex minus .2ex}{0.2ex}
\titlespacing*{\paragraph}{0pt}{0.8ex plus .3ex}{0.8em}

\RequirePackage{titletoc}
\titlecontents{section}[1.7em]
  {\addvspace{4pt}\sffamily\bfseries\color{umink}}
  {\contentslabel[\color{milapurple}\thecontentslabel]{1.7em}}{\hspace*{-1.7em}}
  {\hfill\contentspage}
\titlecontents{subsection}[4.1em]
  {\sffamily\small}
  {\contentslabel[\color{milapurple}\thecontentslabel]{2.4em}}{\hspace*{-2.4em}}
  {\titlerule*[0.7pc]{.}\contentspage}

% Captions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "Figure 1" in brand purple, then the text; a one-line caption is centred,
% a longer one is justified.
\RequirePackage{caption}
\RequirePackage{subcaption}
\DeclareCaptionFont{UMlabel}{\sffamily\bfseries\color{milapurple}}
\DeclareCaptionLabelSeparator{UMspace}{\hspace{0.55em}}
\captionsetup{font=small, labelfont=UMlabel, labelsep=UMspace,
  singlelinecheck=true, justification=justified, skip=6pt}
\captionsetup[table]{position=top}
\captionsetup[sub]{font=small, labelfont={sf,bf}, labelformat=parens,
  labelsep=space}

% Title-block data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Each list accumulates rendered items; a separator goes in front of every item
% after the first.
\newcommand\UM@additem[3]{% list, separator, item
  \ifdefempty{#1}{}{\gappto#1{#2}}\gappto#1{#3}}

% Author marks accept either text or maths symbols: \dagger is mapped to
% \textdagger so marks stay in Inter instead of switching to the maths font.
\newcommand\UM@marksfont{\sffamily\mdseries}
\newcommand\UM@marks[1]{{\UM@marksfont\let\dagger\textdagger
  \let\ddagger\textdaggerdbl #1}}

\newcommand\UM@title{}
\renewcommand\title[1]{\renewcommand\UM@title{#1}}
\newcommand\UM@runningtitle{}
\newcommand\runningtitle[1]{\renewcommand\UM@runningtitle{#1}}
\newcommand\UM@reportlabel{Preprint}
\newcommand\reportlabel[1]{\renewcommand\UM@reportlabel{#1}}

\newcommand\UM@authors{}
\newcommand\UM@authorsep{, }
\renewcommand\author[2][]{\UM@additem\UM@authors{\UM@authorsep}%
  {\mbox{#2\ifblank{#1}{}{\textsuperscript{\UM@marks{#1}}}}}}

\newcommand\UM@affiliations{}
\newcommand\affiliation[2][]{\UM@additem\UM@affiliations{\UM@affilsep}%
  {\mbox{\ifblank{#1}{}{\textsuperscript{\UM@marks{#1}}}#2}}}
\newcommand\UM@affilsep{\hspace{0.9em plus 0.3em}\allowbreak}

\newcommand\UM@contributions{}
\newcommand\contribution[2][]{\UM@additem\UM@contributions{\UM@affilsep}%
  {\mbox{\ifblank{#1}{}{\textsuperscript{\UM@marks{#1}}}#2}}}

\newcommand\UM@abstract{}
\renewcommand\abstract[1]{\renewcommand\UM@abstract{#1}}

% Metadata lines: \metadata[Key]{Value}, or with an icon as
% \metadata[Key][\faBook]{Value}. The named helpers below are shortcuts.
\newcommand\UM@metadata{}
\NewDocumentCommand\metadata{O{} O{\faAngleRight} m}{%
  \UM@additem\UM@metadata{\UM@metasep}{\UM@metaitem{#2}{#1}{#3}}}
\newcommand\UM@metaitem[3]{% icon, key, value; wrapped lines hang under the key
  \UM@metahang
  \mbox{\makebox[1.25em][l]{\color{milapurple}#1}%
  \ifblank{#2}{}{{\bfseries\color{umink}#2:}\ }}{\color{umgrey}#3}}
\newcommand\UM@metasep{\par}
\newcommand\UM@metahang{\hangindent=1.25em\hangafter=1\relax}

\newcommand\email[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand\UM@datetext{}
\renewcommand\date[1]{\renewcommand\UM@datetext{#1}\metadata[Date][\faCalendar*]{#1}}
\newcommand\correspondence[1]{\metadata[Correspondence][\faEnvelope[regular]]{#1}}
\newcommand\github[1]{\metadata[Code][\faGithub]{#1}}
\newcommand\huggingface[1]{\metadata[Hugging Face][\raisebox{-0.15em}{%
  \includegraphics[height=1em]{\UM@asset{logo-huggingface.png}}}]{#1}}
\newcommand\projectpage[1]{\metadata[Project page][\faGlobe]{#1}}
\newcommand\blogpost[1]{\metadata[Blog][\faPenNib]{#1}}

% Aliases so papers written for fairmeta, servicenow or bytedance_seed port by
% changing only \documentclass.
\NewCommandCopy\checkdata\metadata
\newcommand\morelinks[1]{\metadata[More links][\faLink]{#1}}
\providecommand\nm[1]{#1}

% Lab identity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The lab wordmark is set in type, the first part in semibold and the second
% in regular weight: \lab{Bang}{Lab}. \labdescriptor is the small line that
% goes with it, and \labname prints the wordmark in running text.
\newcommand\UM@labfirst{Bang}
\newcommand\UM@labsecond{Lab}
\newcommand\lab[2]{\renewcommand\UM@labfirst{#1}\renewcommand\UM@labsecond{#2}}
\newcommand\UM@labdescriptor{Universit\'e de Montr\'eal \textperiodcentered{} Mila}
\newcommand\labdescriptor[1]{\renewcommand\UM@labdescriptor{#1}}
% #1 = colour of the first part, #2 = colour of the second part.
\newcommand\UM@wordmark[2]{{\sffamily\mbox{{\bfseries\color{#1}\UM@labfirst}%
  {\mdseries\color{#2}\UM@labsecond}}}}
\newcommand\labname{\UM@wordmark{umink}{milapurple}}

% Extras that only some styles print: a page-one teaser figure (teaser), key
% numbers (highlights), a report number (letterhead), a copyright line
% (letterhead, minimal) and a French abstract with its label (bilingual).
\newcommand\UM@teaser{}
\newcommand\UM@teasercaption{}
\newcommand\teaser[2]{\renewcommand\UM@teaser{#1}\renewcommand\UM@teasercaption{#2}}
\newcommand\UM@highlights{}
\newcommand\highlight[2]{\UM@additem\UM@highlights{\UM@highlightsep}{\UM@highlightitem{#1}{#2}}}
\newcommand\UM@highlightsep{\par\vspace{3.6mm}}
\newcommand\UM@highlightitem[2]{{\sffamily\bfseries\fontsize{21}{23}\selectfont
  \color{milapurple}#1\par}\vspace{0.8mm}{\sffamily\fontsize{8.5}{11}\selectfont\color{umgrey}#2\par}}
\newcommand\UM@reportnumber{}
\newcommand\reportnumber[1]{\renewcommand\UM@reportnumber{#1}}
\newcommand\UM@copyright{}
\newcommand\copyrightnote[1]{\renewcommand\UM@copyright{#1}}
\newcommand\UM@frenchabstract{}
\newcommand\frenchabstract[1]{\renewcommand\UM@frenchabstract{#1}}
\newcommand\UM@frenchlabel{Rapport technique}
\newcommand\frenchreportlabel[1]{\renewcommand\UM@frenchlabel{#1}}

% Title-block pieces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\UM@nohyphens{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}

\newcommand\UM@printtitle{{\UM@nohyphens\sffamily\bfseries
  \fontsize{20.5}{25.5}\selectfont\color{umink}\UM@title\par}}
\newcommand\UM@printauthors{\ifdefempty\UM@authors{}{{\sffamily\bfseries
  \fontsize{10.5}{15}\selectfont\color{umink}\UM@authors\par}}}
\newcommand\UM@printaffiliations{\ifdefempty\UM@affiliations{}{{\sffamily
  \fontsize{9}{12.5}\selectfont\color{umgrey}\UM@affiliations\par}}}
\newcommand\UM@printcontributions{\ifdefempty\UM@contributions{}{{\sffamily
  \fontsize{8}{11}\selectfont\color{umgrey}\UM@contributions\par}}}
\newcommand\UM@printabstract{{\normalsize\color{umink!90}\UM@abstract\par}}
\newcommand\UM@printmetadata{\ifdefempty\UM@metadata{}{{\sffamily
  \fontsize{8.5}{12.5}\selectfont\UM@metadata\par}}}
% The same items flowing along a line instead of one per line.
\newcommand\UM@metaalign{\raggedright}
\newcommand\UM@printmetadatainline{\ifdefempty\UM@metadata{}{{\sffamily
  \fontsize{8.5}{14}\selectfont\UM@metaalign
  \def\UM@metasep{\hspace{1.8em plus 0.8em}\allowbreak}\let\UM@metahang\relax
  \UM@metadata\par}}}

\newcommand\UM@printteaser{\ifdefempty\UM@teaser{}{%
  {\centering\UM@teaser\par}\vspace{1mm}\captionof{figure}{\UM@teasercaption}}}
\newcommand\UM@printcopyright{\ifdefempty\UM@copyright{}{%
  \begingroup\renewcommand\thefootnote{}%
  \footnotetext{\sffamily\scriptsize\color{umgrey}\UM@copyright}\endgroup}}
% A small spaced-capitals label over a block, used by several styles.
\newcommand\UM@blocklabel[1]{{\sffamily\bfseries\tiny\color{umgrey}\UM@spaced{#1}\par}\vspace{1.5mm}}
% The front matter one item per line, for the column layouts.
\newcommand\UM@stackedauthors{{\def\UM@authorsep{\par}\sffamily
  \fontsize{9}{13}\selectfont\color{umink}\UM@authors\par}}
\newcommand\UM@stackedaffiliations{{\def\UM@affilsep{\par}\sffamily
  \fontsize{8.5}{12}\selectfont\color{umgrey}\UM@affiliations\par}%
  \ifdefempty\UM@contributions{}{\vspace{1.6mm}{\def\UM@affilsep{\par}\sffamily
  \fontsize{7.5}{10.5}\selectfont\color{umgrey}\UM@contributions\par}}}
% In a narrow column each value goes on its own line under its key, so an
% address that cannot break never has to share a line with the key.
\newcommand\UM@stackedmetadata{\ifdefempty\UM@metadata{}{{\sffamily
  \fontsize{8}{11.5}\selectfont\raggedright
  \def\UM@metasep{\par\vspace{1.6mm}}%
  \def\UM@metaitem##1##2##3{\mbox{\makebox[1.25em][l]{\color{milapurple}##1}%
    \ifblank{##2}{}{{\bfseries\color{umink}##2}}}\par
    {\leftskip=1.25em\color{umgrey}##3\par}}%
  \UM@metadata\par}}}
\newcommand\UM@titleat[2]{% size, leading
  {\raggedright\UM@nohyphens\sffamily\bfseries\fontsize{#1}{#2}\selectfont
  \color{umink}\UM@title\par}}
\newcommand\UM@reportline{\ifdefempty\UM@reportlabel{}{{\sffamily\bfseries
  \scriptsize\color{milapurple}\UM@spaced{\UM@reportlabel}\par}\vspace{2.6mm}}}
\newcommand\UM@byline{\UM@printauthors\vspace{1.4mm}\UM@printaffiliations
  \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}}
\newcommand\UM@plainabstract[1]{% label
  {\sffamily\bfseries\scriptsize\color{milapurple}\UM@spaced{#1}\par}\vspace{2mm}%
  {\color{umink!90}\UM@abstract\par}}
\newcommand\UM@closingrule{\vspace{4mm}{\color{umrule}\hrule height 0.4pt}\vspace{1mm}}
\newcommand\UM@wordmarkrow[2]{% wordmark size, logo height
  \noindent{\fontsize{#1}{#1}\selectfont\UM@wordmark{umink}{milapurple}}\hfill
  \UM@lockup{#2}{}{umrule}\par}

% Letter-spaced capitals for the report label.
\newcommand\UM@spaced[1]{\textls[110]{\MakeUppercase{#1}}}

% UdeM and Mila side by side, divided by a hairline. #1 = logo height,
% #2 = file suffix (empty for colour, -white on a coloured ground),
% #3 = divider colour.
\newcommand\UM@lockup[3]{%
  \mbox{\includegraphics[height=1.18\dimexpr#1\relax]{\UM@asset{logo-udem#2.pdf}}%
  \hspace{0.55\dimexpr#1\relax}%
  {\color{#3}\rule[-0.02\dimexpr#1\relax]{0.5pt}{1.04\dimexpr#1\relax}}%
  \hspace{0.55\dimexpr#1\relax}%
  \includegraphics[height=#1]{\UM@asset{logo-mila#2.pdf}}}}

% The brand marks alone (UdeM crest, Mila network glyph), for the running head.
\newcommand\UM@marksonly[1]{%
  \mbox{\includegraphics[height=#1, trim=1690 318 0 0, clip]{\UM@asset{logo-udem.pdf}}%
  \hspace{0.5\dimexpr#1\relax}%
  \includegraphics[height=#1, trim=0 0 118 0, clip]{\UM@asset{logo-mila.pdf}}}}

% Title style: card %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A tinted rounded card holding the whole front matter, a purple-to-blue edge
% on its left, and the logos beside the metadata (Meta FAIR, ServiceNow).
\newsavebox\UM@lockupbox
\newcommand\UM@maketitle@card{%
  \sbox\UM@lockupbox{\UM@lockup{7.2mm}{}{umrule}}%
  \begin{tcolorbox}[enhanced, frame hidden, arc=9pt, boxrule=0pt, colback=umtint,
      left=0.75cm, right=0.75cm, top=0.65cm, bottom=0.6cm,
      before skip=0pt, after skip=0pt,
      overlay={\begin{scope}
          \clip[rounded corners=9pt] (frame.south west) rectangle (frame.north east);
          \shade[top color=milapurple, bottom color=udemblue]
            (frame.south west) rectangle ([xshift=4.5pt]frame.north west);
        \end{scope}}]
    {\raggedright
      \ifdefempty\UM@reportlabel{}{{\sffamily\bfseries\scriptsize\color{milapurple}%
        \UM@spaced{\UM@reportlabel}\par}\vspace{2.2mm}}%
      \UM@printtitle
      \vspace{3.5mm}\UM@printauthors
      \vspace{1.4mm}\UM@printaffiliations
      \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}\par}%
    \vspace{5mm}%
    \UM@printabstract
    \vspace{5mm}%
    \begin{minipage}[b]{\dimexpr\linewidth-\wd\UM@lockupbox-0.6cm\relax}
      \UM@printmetadata
    \end{minipage}\hfill\usebox\UM@lockupbox
  \end{tcolorbox}}

% Title style: band %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A full-bleed purple band across the top of page one carrying white logos and
% the report label; the front matter sits on the page below it.
\newlength\UM@bandheight
\setlength\UM@bandheight{2.35cm}
\newcommand\UM@band{%
  \AddToShipoutPictureBG*{\AtPageUpperLeft{%
    \raisebox{-\UM@bandheight}{\begin{tikzpicture}[inner sep=0pt]
      \shade[left color=milapurple, right color=milapurple!55!udemblue]
        (0,0) rectangle (\paperwidth,\UM@bandheight);
      \fill[udemblue] (0,0) rectangle (\paperwidth,1.6pt);
      \node[anchor=west] at (2.5cm,0.5\UM@bandheight)
        {\UM@lockup{8.5mm}{-white}{white!55!milapurple}};
      \node[anchor=east, align=right, text=white, font=\sffamily\bfseries\scriptsize]
        at ([xshift=-2.5cm]\paperwidth,0.5\UM@bandheight)
        {\UM@spaced{\UM@reportlabel}};
    \end{tikzpicture}}}}}
\newcommand\UM@maketitle@band{%
  \UM@band
  \vspace*{0.45cm}%
  {\raggedright
    \UM@printtitle
    \vspace{4mm}\UM@printauthors
    \vspace{1.4mm}\UM@printaffiliations
    \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}\par}%
  \vspace{5.5mm}%
  \begin{tcolorbox}[enhanced, blank, borderline west={2.2pt}{0pt}{milapurple},
      left=0.55cm, right=0pt, top=0.5mm, bottom=0.5mm, before skip=0pt, after skip=0pt]
    {\sffamily\bfseries\small\color{milapurple}Abstract\par}\vspace{1.2mm}%
    \UM@printabstract
  \end{tcolorbox}%
  \ifdefempty\UM@metadata{}{%
    \vspace{4mm}%
    \begin{tcolorbox}[enhanced, frame hidden, arc=5pt, boxrule=0pt, colback=umtint,
        left=0.55cm, right=0.4cm, top=2.2mm, bottom=2.2mm,
        before skip=0pt, after skip=0pt]
      \UM@printmetadata
    \end{tcolorbox}}%
  \vspace{2mm}}

% Title style: rule %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Colour logos in the page-one header, a centred title between purple rules and
% an outlined abstract panel with the metadata inside (ByteDance Seed, LeapLab).
\newcommand\UM@ruleheader{%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{%
    \put(\LenToUnit{2.5cm},\LenToUnit{-2.05cm}){\UM@lockup{7.5mm}{}{umrule}}%
    \put(\LenToUnit{\dimexpr\paperwidth-2.5cm\relax},\LenToUnit{-1.55cm}){%
      \makebox[0pt][r]{\sffamily\bfseries\scriptsize\color{umgrey}%
        \UM@spaced{\UM@reportlabel}}}}}}
\newcommand\UM@maketitle@rule{%
  \UM@ruleheader
  \vspace*{0.35cm}%
  {\centering
    {\color{milapurple}\rule{\linewidth}{0.6pt}}\par\vspace{5mm}%
    \UM@printtitle
    \vspace{3mm}{\color{milapurple}\rule{\linewidth}{0.6pt}}\par
    \vspace{5mm}\UM@printauthors
    \vspace{1.6mm}\UM@printaffiliations
    \ifdefempty\UM@contributions{}{\vspace{1mm}\UM@printcontributions}\par}%
  \vspace{6mm}%
  \begin{tcolorbox}[enhanced, arc=2.5mm, boxrule=0.6pt, colframe=milapurple,
      colback=white, left=7mm, right=7mm, top=4.5mm, bottom=4.5mm,
      before skip=0pt, after skip=0pt]
    {\centering\sffamily\bfseries\color{milapurple}Abstract\par}\vspace{2.5mm}%
    \UM@printabstract
    \ifdefempty\UM@metadata{}{\vspace{3.5mm}\UM@printmetadata}%
  \end{tcolorbox}}

% Title style: labcard %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The card without its coloured edge. The lab wordmark and report label open
% the card, and the logos sit beside the metadata as in card.
\newcommand\UM@labline{%
  {\fontsize{11}{13}\selectfont\UM@wordmark{umink}{milapurple}}%
  \ifdefempty\UM@reportlabel{}{\hspace{0.7em}%
    {\color{umrule}\rule[-0.2em]{0.5pt}{1.05em}}\hspace{0.7em}%
    {\sffamily\bfseries\scriptsize\color{umgrey}\UM@spaced{\UM@reportlabel}}}\par}
\newcommand\UM@maketitle@labcard{%
  \sbox\UM@lockupbox{\UM@lockup{7.2mm}{}{umrule}}%
  \begin{tcolorbox}[enhanced, frame hidden, arc=9pt, boxrule=0pt, colback=umtint,
      left=0.75cm, right=0.75cm, top=0.6cm, bottom=0.6cm,
      before skip=0pt, after skip=0pt]
    {\raggedright
      \UM@labline
      \vspace{4mm}\UM@printtitle
      \vspace{3.5mm}\UM@printauthors
      \vspace{1.4mm}\UM@printaffiliations
      \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}\par}%
    \vspace{5mm}%
    \UM@printabstract
    \vspace{5mm}%
    \begin{minipage}[b]{\dimexpr\linewidth-\wd\UM@lockupbox-0.6cm\relax}
      \UM@printmetadata
    \end{minipage}\hfill\usebox\UM@lockupbox
  \end{tcolorbox}}

% Title style: labband %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A solid purple band with the lab wordmark in white on the left and the white
% UdeM and Mila logos on the right. The abstract and metadata share one tinted
% panel on the page below.
\newcommand\UM@labbandbg{%
  \AddToShipoutPictureBG*{\AtPageUpperLeft{%
    \raisebox{-\UM@bandheight}{\begin{tikzpicture}[inner sep=0pt]
      \fill[milapurple] (0,0) rectangle (\paperwidth,\UM@bandheight);
      \node[anchor=west, align=left] at (2.5cm,0.5\UM@bandheight)
        {{\fontsize{21}{22}\selectfont\UM@wordmark{white}{white!72!milapurple}}\\[2.2mm]
         {\sffamily\bfseries\tiny\color{white!78!milapurple}\UM@spaced{\UM@labdescriptor}}};
      \node[anchor=east] at ([xshift=-2.5cm]\paperwidth,0.5\UM@bandheight)
        {\UM@lockup{8mm}{-white}{white!45!milapurple}};
    \end{tikzpicture}}}}}
\newcommand\UM@maketitle@labband{%
  \UM@labbandbg
  \vspace*{0.45cm}%
  {\raggedright
    \ifdefempty\UM@reportlabel{}{{\sffamily\bfseries\scriptsize\color{milapurple}%
      \UM@spaced{\UM@reportlabel}\par}\vspace{2.6mm}}%
    \UM@printtitle
    \vspace{4mm}\UM@printauthors
    \vspace{1.4mm}\UM@printaffiliations
    \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}\par}%
  \vspace{5.5mm}%
  \begin{tcolorbox}[enhanced, frame hidden, arc=7pt, boxrule=0pt, colback=umtint,
      left=0.65cm, right=0.65cm, top=0.5cm, bottom=0.45cm,
      before skip=0pt, after skip=0pt]
    {\sffamily\bfseries\small\color{milapurple}Abstract\par}\vspace{1.6mm}%
    \UM@printabstract
    \ifdefempty\UM@metadata{}{\vspace{3.5mm}{\color{umrule}\hrule height 0.4pt}%
      \vspace{2.6mm}\UM@printmetadatainline}%
  \end{tcolorbox}%
  \vspace{2mm}}

% Title style: masthead %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% An editorial first page with no boxes. A masthead carries the lab wordmark
% and descriptor on the left and the colour logos on the right above a
% hairline, and the abstract is set as text under a spaced-capitals label.
\newcommand\UM@maketitle@masthead{%
  \vspace*{-0.35cm}%
  \noindent
  \begin{minipage}[b]{0.5\linewidth}
    {\fontsize{25}{26}\selectfont\UM@wordmark{umink}{milapurple}}\par\vspace{1.6mm}%
    {\sffamily\bfseries\tiny\color{umgrey}\UM@spaced{\UM@labdescriptor}}%
  \end{minipage}\hfill
  \UM@lockup{7.2mm}{}{umrule}\par
  \vspace{3.2mm}{\color{umink}\hrule height 0.8pt}\vspace{0.9pt}%
  {\color{umink}\hrule height 0.3pt}%
  \vspace{7mm}%
  {\raggedright
    \ifdefempty\UM@reportlabel{}{{\sffamily\bfseries\scriptsize\color{milapurple}%
      \UM@spaced{\UM@reportlabel}\par}\vspace{2.6mm}}%
    {\UM@nohyphens\sffamily\bfseries\fontsize{23}{28}\selectfont\color{umink}%
      \UM@title\par}%
    \vspace{4.5mm}\UM@printauthors
    \vspace{1.4mm}\UM@printaffiliations
    \ifdefempty\UM@contributions{}{\vspace{0.8mm}\UM@printcontributions}\par}%
  \vspace{7mm}%
  {\sffamily\bfseries\scriptsize\color{milapurple}\UM@spaced{Abstract}\par}%
  \vspace{2mm}%
  {\fontsize{10.5}{14.2}\selectfont\color{umink!90}\UM@abstract\par}%
  \ifdefempty\UM@metadata{}{\vspace{4mm}\UM@printmetadatainline}%
  \vspace{4mm}{\color{umrule}\hrule height 0.4pt}\vspace{1mm}}

% Title style: cover %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Page one is a cover in Mila purple with the wordmark, title, authors, links
% and white logos; the abstract opens page two.
\newif\ifUM@wastwocolumn
\newcommand\UM@coverpage{%
  \thispagestyle{empty}%
  \AddToShipoutPictureBG*{\AtPageLowerLeft{\color{milapurple}\rule{\paperwidth}{\paperheight}}}%
  \begingroup
    \colorlet{umink}{white}\colorlet{umgrey}{white!76!milapurple}%
    \setlength\parskip{0pt}\setlength\parindent{0pt}%
    \noindent\begin{minipage}[t][\dimexpr\textheight-4mm\relax][t]{\linewidth}
      \raggedright
      {\fontsize{24}{26}\selectfont\UM@wordmark{white}{white!70!milapurple}}\hfill
      {\sffamily\bfseries\scriptsize\color{white!76!milapurple}\UM@spaced{\UM@reportlabel}}\par
      \vspace{2mm}{\sffamily\bfseries\tiny\color{white!76!milapurple}\UM@spaced{\UM@labdescriptor}}\par
      \vfill
      {\UM@nohyphens\sffamily\bfseries\fontsize{34}{40}\selectfont\color{white}\UM@title\par}%
      \vspace{10mm}\UM@byline
      \vfill\vfill
      \begin{minipage}[b]{0.58\linewidth}\colorlet{milapurple}{white}\UM@printmetadata\end{minipage}\hfill
      \UM@lockup{8.5mm}{-white}{white!45!milapurple}\par
    \end{minipage}
  \endgroup}
\newcommand\UM@coverabstract{%
  \setlength\parskip{0pt}\setlength\parindent{0pt}%
  \UM@reportline\UM@titleat{17}{21.5}\vspace{6mm}%
  \UM@plainabstract{Abstract}\UM@closingrule}
\newcommand\UM@maketitlecover{%
  \UM@wastwocolumnfalse
  \if@twocolumn\UM@wastwocolumntrue\onecolumn\fi
  \UM@coverpage\clearpage
  \ifUM@wastwocolumn
    \twocolumn[{\UM@coverabstract}\vspace{5mm}]%
  \else
    {\UM@coverabstract}\vspace{5mm}%
  \fi}

% Title style: hero %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A deep aubergine block, full width from the top edge of the page, holds the
% wordmark, logos, title and authors in white; the abstract sits below it.
\newsavebox\UM@herobox
\newlength\UM@heroheight
\newcommand\UM@maketitle@hero{%
  \sbox\UM@herobox{\begin{minipage}{\linewidth}\setlength\parskip{0pt}\raggedright
    \colorlet{umink}{white}\colorlet{umgrey}{white!70!umnight}%
    {\fontsize{12}{14}\selectfont\UM@wordmark{white}{white!62!milapurple}}\hfill
      \raisebox{-1.6mm}{\UM@lockup{6.4mm}{-white}{white!30!umnight}}\par
    \vspace{13mm}%
    \ifdefempty\UM@reportlabel{}{{\sffamily\bfseries\scriptsize\color{white!62!milapurple}%
      \UM@spaced{\UM@reportlabel}\par}\vspace{3mm}}%
    {\UM@nohyphens\sffamily\bfseries\fontsize{26}{31}\selectfont\color{white}\UM@title\par}%
    \vspace{6mm}\UM@byline
  \end{minipage}}%
  \global\UM@heroheight=\dimexpr 1.3cm+\ht\UM@herobox+\dp\UM@herobox+1.05cm\relax
  \AddToShipoutPictureBG*{\AtPageUpperLeft{\raisebox{-\UM@heroheight}{%
    \color{umnight}\rule{\paperwidth}{\UM@heroheight}}}}%
  \vspace*{-1.2cm}\noindent\usebox\UM@herobox\par
  \vspace{1.05cm}\vspace{7mm}%
  \UM@plainabstract{Abstract}%
  \ifdefempty\UM@metadata{}{\vspace{4mm}\UM@printmetadatainline}%
  \UM@closingrule}

% Title style: teaser %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% After Kimi, GLM and MiMo: a wordmark and logo header, a centred title between
% a heavy and a light rule, centred links, a narrow abstract and the teaser
% figure set by \teaser on page one.
\newcommand\UM@teaserheader{%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{%
    \put(\LenToUnit{2.5cm},\LenToUnit{-1.8cm}){{\fontsize{11}{12}\selectfont\UM@wordmark{umink}{milapurple}}}%
    \put(\LenToUnit{\dimexpr\paperwidth-2.5cm\relax},\LenToUnit{-1.92cm}){%
      \makebox[0pt][r]{\UM@lockup{5.6mm}{}{umrule}}}%
    \put(\LenToUnit{2.5cm},\LenToUnit{-2.18cm}){{\color{umrule}\rule{\dimexpr\paperwidth-5cm\relax}{0.4pt}}}}}}
\newcommand\UM@maketitle@teaser{%
  \UM@teaserheader
  \vspace*{0.25cm}%
  {\centering
    {\color{umink}\rule{\linewidth}{1.6pt}}\par\vspace{4.5mm}%
    {\UM@nohyphens\sffamily\bfseries\fontsize{19}{24}\selectfont\color{umink}\UM@title\par}%
    \vspace{3.8mm}{\color{umink}\rule{\linewidth}{0.5pt}}\par
    \ifdefempty\UM@reportlabel{}{\vspace{2.8mm}{\sffamily\bfseries\scriptsize\color{milapurple}%
      \UM@spaced{Technical report of \UM@labfirst\UM@labsecond}}\par}%
    \vspace{4mm}\UM@byline
    \ifdefempty\UM@metadata{}{\vspace{2.6mm}{\def\UM@metaalign{\centering}\UM@printmetadatainline}}%
    \par}%
  \vspace{5mm}%
  {\centering\sffamily\bfseries\color{umink}Abstract\par}\vspace{2mm}%
  {\leftskip=1.1cm\rightskip=1.1cm\color{umink!90}\UM@abstract\par}%
  \ifdefempty\UM@teaser{}{\vspace{5mm}\UM@printteaser}}

% Title style: split %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Two columns under a wordmark row: authors, affiliations and links stacked on
% the left, the title and abstract on the right.
\newcommand\UM@maketitle@split{%
  \UM@wordmarkrow{13}{6.2mm}%
  \vspace{3mm}{\color{umink}\hrule height 0.8pt}\vspace{8mm}%
  \noindent
  \begin{minipage}[t]{0.285\linewidth}\raggedright\vspace{0pt}%
    \UM@blocklabel{Authors}\UM@stackedauthors
    \vspace{5mm}\UM@blocklabel{Affiliations}\UM@stackedaffiliations
    \ifdefempty\UM@metadata{}{\vspace{5mm}\UM@blocklabel{Links}\UM@stackedmetadata}%
  \end{minipage}\hfill
  \begin{minipage}[t]{0.665\linewidth}\vspace{0pt}%
    \UM@reportline\UM@titleat{22}{27}%
    \vspace{7mm}\UM@blocklabel{Abstract}%
    {\color{umink!90}\UM@abstract\par}%
  \end{minipage}\par
  \UM@closingrule}

% Title style: swiss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% International typographic style: a heavy rule, an oversized flush-left title,
% a three-column grid of authors, affiliations and links, and a sans abstract.
% The whole paper is set in Inter under this style.
\newcommand\UM@swisscol[2]{\begin{minipage}[t]{0.31\linewidth}\raggedright\vspace{0pt}%
  {\sffamily\bfseries\tiny\color{umink}\UM@spaced{#1}\par}\vspace{1.8mm}#2\end{minipage}}
\newcommand\UM@maketitle@swiss{%
  \UM@wordmarkrow{12}{5.8mm}%
  \vspace{3mm}{\color{umink}\hrule height 2.4pt}\vspace{2.2mm}%
  {\sffamily\bfseries\tiny\color{umink}\UM@spaced{\UM@reportlabel}\hfill
    \UM@spaced{\UM@datetext}\par}%
  \vspace{10mm}\UM@titleat{31}{35}%
  \vspace{10mm}{\color{umink}\hrule height 0.5pt}\vspace{3mm}%
  \noindent\UM@swisscol{Authors}{\UM@stackedauthors}\hfill
  \UM@swisscol{Affiliations}{\UM@stackedaffiliations}\hfill
  \UM@swisscol{Links}{\UM@stackedmetadata}\par
  \vspace{9mm}%
  {\raggedright\sffamily\fontsize{11}{15.5}\selectfont\color{umink}\UM@abstract\par}%
  \vspace{6mm}{\color{umink}\hrule height 0.5pt}\vspace{1mm}}

% Title style: highlights %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The abstract beside a tinted panel of key numbers from \highlight, the way
% model reports lead with their headline results.
\newcommand\UM@maketitle@highlights{%
  \noindent{\fontsize{12}{14}\selectfont\UM@wordmark{umink}{milapurple}}%
    \hspace{0.7em}{\color{umrule}\rule[-0.2em]{0.5pt}{1.05em}}\hspace{0.7em}%
    {\sffamily\bfseries\scriptsize\color{umgrey}\UM@spaced{\UM@reportlabel}}\hfill
    \UM@lockup{5.8mm}{}{umrule}\par
  \vspace{10mm}\UM@titleat{22}{27}%
  \vspace{4.5mm}{\raggedright\UM@byline\par}%
  \vspace{8mm}%
  \noindent
  \begin{minipage}[t]{\ifdefempty\UM@highlights{\linewidth}{0.6\linewidth}}\vspace{0pt}%
    \UM@plainabstract{Abstract}%
    \ifdefempty\UM@metadata{}{\vspace{4mm}\UM@printmetadata}%
  \end{minipage}\hfill
  \ifdefempty\UM@highlights{}{%
  \begin{minipage}[t]{0.345\linewidth}\vspace{0pt}%
    \begin{tcolorbox}[enhanced, frame hidden, arc=7pt, boxrule=0pt, colback=umtint,
        left=5mm, right=5mm, top=4.5mm, bottom=5mm, before skip=0pt, after skip=0pt]
      \setlength\parskip{0pt}\raggedright
      {\sffamily\bfseries\scriptsize\color{milapurple}\UM@spaced{Highlights}\par}\vspace{4mm}%
      \UM@highlights
    \end{tcolorbox}
  \end{minipage}}\par
  \UM@closingrule}

% Title style: letterhead %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A report series: centred logos, a ruled line with the series label, report
% number and date, a small-capitals title and a serif front matter. Headings
% switch to the serif under this style, and \copyrightnote closes page one.
\newcommand\UM@maketitle@letterhead{%
  {\centering
    \UM@lockup{7.4mm}{}{umrule}\par
    \vspace{5mm}{\color{umink}\rule{\linewidth}{0.4pt}}\par\vspace{1.8mm}%
    {\sffamily\bfseries\tiny\color{umgrey}\UM@spaced{\UM@labfirst\UM@labsecond{} \UM@reportlabel}%
      \ifdefempty\UM@reportnumber{}{\hspace{1.2em}\textperiodcentered\hspace{1.2em}\UM@spaced{\UM@reportnumber}}%
      \ifdefempty\UM@datetext{}{\hspace{1.2em}\textperiodcentered\hspace{1.2em}\UM@spaced{\UM@datetext}}\par}%
    \vspace{1.8mm}{\color{umink}\rule{\linewidth}{0.4pt}}\par
    \vspace{11mm}%
    {\UM@nohyphens\rmfamily\scshape\fontsize{19}{25}\selectfont\color{umink}\UM@title\par}%
    \vspace{7mm}%
    {\def\UM@marksfont{\rmfamily}\rmfamily\fontsize{11}{15}\selectfont\color{umink}\UM@authors\par}%
    \vspace{2mm}{\def\UM@marksfont{\rmfamily}\rmfamily\itshape\fontsize{9.5}{13}\selectfont
      \color{umgrey}\UM@affiliations\par}%
    \ifdefempty\UM@contributions{}{\vspace{1mm}{\def\UM@marksfont{\rmfamily}\rmfamily
      \fontsize{8.5}{11}\selectfont\color{umgrey}\UM@contributions\par}}%
    \vspace{8mm}{\rmfamily\scshape\color{umink}Abstract\par}\vspace{2mm}\par}%
  {\leftskip=1.5cm\rightskip=1.5cm\small\color{umink!90}\UM@abstract\par}%
  \ifdefempty\UM@metadata{}{\vspace{4.5mm}{\def\UM@metaalign{\centering}\UM@printmetadatainline}}%
  \vspace{3mm}}

% Title style: bilingual %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Montreal's two languages: a French and English report label, and the English
% abstract beside its French résumé from \frenchabstract.
\newcommand\UM@maketitle@bilingual{%
  \UM@wordmarkrow{12}{5.8mm}%
  \vspace{3mm}{\color{umrule}\hrule height 0.5pt}\vspace{2.2mm}%
  {\sffamily\bfseries\tiny\color{umgrey}\UM@spaced{\UM@frenchlabel}\hspace{0.8em}/\hspace{0.8em}%
    \UM@spaced{\UM@reportlabel}\hfill\UM@spaced{Montr\'eal}\par}%
  \vspace{10mm}\UM@titleat{22}{27}%
  \vspace{4.5mm}{\raggedright\UM@byline\par}%
  \vspace{8mm}%
  \ifdefempty\UM@frenchabstract{\UM@plainabstract{Abstract}}{%
    \noindent
    \begin{minipage}[t]{0.475\linewidth}\vspace{0pt}%
      {\sffamily\bfseries\scriptsize\color{milapurple}\UM@spaced{Abstract}\par}\vspace{2mm}%
      {\small\color{umink!90}\UM@abstract\par}%
    \end{minipage}\hfill
    \begin{minipage}[t]{0.475\linewidth}\vspace{0pt}%
      {\sffamily\bfseries\scriptsize\color{milapurple}\UM@spaced{R\'esum\'e}\par}\vspace{2mm}%
      {\small\hyphenpenalty=5000\color{umink!90}\UM@frenchabstract\par}%
    \end{minipage}\par}%
  \ifdefempty\UM@metadata{}{\vspace{5mm}\UM@printmetadatainline}%
  \UM@closingrule}

% Title style: motif %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A pale network in the top-right corner, dots on its left half and a
% triangular lattice on its right, echoing the Mila glyph. The same seed draws
% the same pattern on every build.
\newcommand\UM@motifdraw{%
  \begin{tikzpicture}[overlay, x=1cm, y=1cm]
    \pgfmathsetseed{20260927}%
    \foreach \j in {0,...,8}{%
      \foreach \i in {0,...,13}{%
        \pgfmathsetmacro\px{\i*0.62+mod(\j,2)*0.31}%
        \pgfmathsetmacro\py{-\j*0.537}%
        \ifnum\i<7
          \pgfmathsetmacro\r{0.045+0.14*rnd}%
          \fill[milapurple!15] (\px,\py) circle (\r);
        \else
          \ifnum\i<13 \draw[milapurple!16, line width=0.45pt] (\px,\py) -- ++(0.62,0);\fi
          \ifnum\j<8
            \draw[milapurple!16, line width=0.45pt] (\px,\py) -- ++(0.31,-0.537);
            \draw[milapurple!16, line width=0.45pt] (\px,\py) -- ++(-0.31,-0.537);
          \fi
          \fill[milapurple!24] (\px,\py) circle (0.04);
        \fi
      }}%
  \end{tikzpicture}}
\newcommand\UM@maketitle@motif{%
  \AddToShipoutPictureBG*{\AtPageUpperLeft{%
    \put(\LenToUnit{\dimexpr\paperwidth-8.3cm\relax},\LenToUnit{-0.75cm}){\UM@motifdraw}}}%
  \sbox\UM@lockupbox{\UM@lockup{6.4mm}{}{umrule}}%
  {\raggedright
    {\fontsize{17}{18}\selectfont\UM@wordmark{umink}{milapurple}}\par\vspace{2mm}%
    {\sffamily\bfseries\tiny\color{umgrey}\UM@spaced{\UM@labdescriptor}}\par
    \vspace{21mm}\UM@reportline\UM@titleat{24}{29}%
    \vspace{5mm}\UM@byline\par}%
  \vspace{8mm}\UM@plainabstract{Abstract}%
  \vspace{5mm}%
  \noindent\begin{minipage}[b]{\dimexpr\linewidth-\wd\UM@lockupbox-0.8cm\relax}
    \UM@printmetadatainline
  \end{minipage}\hfill\usebox\UM@lockupbox\par
  \UM@closingrule}

% Title style: minimal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The plain model-report page of Qwen, DeepSeek and Nemotron: logos left and
% date right in the header, a flush-left title, a list of links, a run-in
% abstract, and \copyrightnote at the foot of page one.
\newcommand\UM@minimalheader{%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{%
    \put(\LenToUnit{2.5cm},\LenToUnit{-2.0cm}){\UM@lockup{5.4mm}{}{umrule}}%
    \put(\LenToUnit{\dimexpr\paperwidth-2.5cm\relax},\LenToUnit{-1.72cm}){%
      \makebox[0pt][r]{\sffamily\footnotesize\color{umgrey}\UM@datetext}}}}}
\newcommand\UM@maketitle@minimal{%
  \UM@minimalheader
  \vspace*{0.55cm}%
  {\raggedright
    {\fontsize{9.5}{11}\selectfont\UM@wordmark{umink}{milapurple}}\hspace{0.45em}%
      {\sffamily\fontsize{9.5}{11}\selectfont\color{umgrey}\UM@reportlabel}\par
    \vspace{3mm}\UM@titleat{20}{25}%
    \vspace{4mm}\UM@byline
    \ifdefempty\UM@metadata{}{\vspace{3mm}\UM@stackedmetadata}\par}%
  \vspace{6mm}%
  {\color{umink!90}{\sffamily\bfseries\color{umink}Abstract.}\hspace{0.5em}\UM@abstract\par}%
  \UM@closingrule}

% \maketitle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\UM@maketitle{%
  \setlength\parskip{0pt}\setlength\parindent{0pt}%
  \ifcsname UM@maketitle@\UM@titlestyle\endcsname
    \csname UM@maketitle@\UM@titlestyle\endcsname
  \else
    \ClassError{udemmila}{Unknown titlestyle `\UM@titlestyle'}%
      {Use one of card, band, rule, labcard, labband, masthead, cover, hero,
       teaser, split, swiss, highlights, letterhead, bilingual, motif or minimal.}%
  \fi}
% Printed after the title block, outside the two-column header.
\newcommand\UM@aftertitle{}
\renewcommand\maketitle{%
  \ifdefstring\UM@titlestyle{cover}{\UM@maketitlecover}{%
    \thispagestyle{UMfirst}%
    \if@twocolumn
      \twocolumn[{\UM@maketitle}\vspace{7mm}]%
    \else
      {\UM@maketitle\par}\vspace{6mm}%
    \fi}%
  \UM@aftertitle
  \global\let\maketitle\relax}

\newcommand\UM@pdftitle{%
  \pdfstringdefDisableCommands{\def\\{ }\let\texttt\@firstofone}%
  \hypersetup{pdftitle={\UM@title}}}
\AtBeginDocument{\UM@pdftitle}

% Headers and footers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}
\ifUM@labstyle
  \newcommand\UM@runninghead{{\fontsize{7.5}{9}\selectfont\UM@wordmark{umink}{milapurple}}%
    \ifdefempty\UM@runningtitle{}{\hspace{0.8em}{\sffamily\scriptsize\color{umgrey}%
      \UM@runningtitle}}}
\else
  \newcommand\UM@runninghead{\sffamily\scriptsize\color{umgrey}\UM@runningtitle}
\fi
\newcommand\UM@pagenumber{{\sffamily\footnotesize\color{umgrey}\thepage}}
\fancypagestyle{UMfirst}{%
  \fancyhf{}\renewcommand\headrulewidth{0pt}%
  \fancyfoot[C]{\UM@pagenumber}}
\fancypagestyle{UMrunning}{%
  \fancyhf{}%
  \fancyhead[L]{\UM@runninghead}%
  \fancyhead[R]{\raisebox{-0.5pt}{\UM@marksonly{3mm}}}%
  \renewcommand\headrulewidth{0.4pt}%
  \renewcommand\headrule{{\color{umrule}\hrule\@height\headrulewidth
    \@width\headwidth\vskip-\headrulewidth}}%
  \fancyfoot[C]{\UM@pagenumber}}
\pagestyle{UMrunning}
\renewcommand\footnoterule{{\color{umrule}\kern-3pt\hrule\@width 3cm\kern 2.6pt}}

% Appendix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \beginappendix starts a new page with an "Appendix" heading and a contents
% list of the appendix sections; \beginappendix* leaves the list out.
\newcommand\UM@appendixheading{%
  {\sffamily\bfseries\fontsize{20}{24}\selectfont\color{umink}Appendix\par}%
  \vspace{1.5mm}{\color{milapurple}\rule{\linewidth}{0.6pt}}\par\vspace{2mm}}
\NewDocumentCommand\beginappendix{s}{%
  \clearpage\appendix
  \UM@appendixheading
  \IfBooleanF{#1}{%
    \startcontents[appendix]%
    \printcontents[appendix]{}{1}{\setcounter{tocdepth}{2}}%
    \vspace{4mm}}}

% Boxes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \begin{takeaway}[Title] ... \end{takeaway}: a finding the reader should keep.
% The lab styles draw it as a plain tinted panel, the others with a left rule.
\ifUM@labstyle
  \newtcolorbox{takeaway}[1][Takeaway]{enhanced, breakable, arc=5pt,
    frame hidden, boxrule=0pt, colback=umtint,
    left=11pt, right=11pt, top=7pt, bottom=7pt, before skip=8pt, after skip=8pt,
    before upper={{\sffamily\bfseries\small\color{milapurple}#1\par}\vspace{2pt}}}
\else
  \newtcolorbox{takeaway}[1][Takeaway]{enhanced, breakable, arc=4pt,
    boxrule=0pt, leftrule=3pt, colframe=milapurple, colback=umtint,
    left=9pt, right=10pt, top=6pt, bottom=6pt, before skip=8pt, after skip=8pt,
    before upper={{\sffamily\bfseries\small\color{milapurple}#1\par}\vspace{2pt}}}
\fi

% \begin{promptbox}[Title] ... \end{promptbox}: a prompt or model output,
% set in Inconsolata; verbatim content is allowed inside.
\newtcolorbox{promptbox}[1][Prompt]{enhanced, breakable, arc=4pt,
  boxrule=0.6pt, colframe=milapurple!55, colback=black!2,
  colbacktitle=milapurple!10, coltitle=umink,
  fonttitle=\sffamily\bfseries\footnotesize, title=#1,
  fontupper=\ttfamily\footnotesize, left=8pt, right=8pt, top=5pt, bottom=5pt,
  before skip=8pt, after skip=8pt}

% Style-specific settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifdefstring\UM@titlestyle{swiss}{\renewcommand*\familydefault{\sfdefault}%
  \setlength\emergencystretch{3em}}{}
\ifdefstring\UM@titlestyle{letterhead}{%
  \titleformat{\section}
    {\rmfamily\bfseries\fontsize{14}{17}\selectfont\color{umink}}
    {\color{milapurple}\thesection}{0.7em}{}%
  \titleformat{\subsection}
    {\rmfamily\bfseries\fontsize{11.5}{14}\selectfont\color{umink}}
    {\color{milapurple}\thesubsection}{0.65em}{}%
  \titleformat{\subsubsection}
    {\rmfamily\bfseries\normalsize\color{umink}}
    {\color{milapurple}\thesubsubsection}{0.6em}{}%
  \titleformat{\paragraph}[runin]
    {\rmfamily\bfseries\normalsize\color{umink}}{\theparagraph}{0.6em}{}%
  \let\UM@aftertitle\UM@printcopyright}{}
\ifdefstring\UM@titlestyle{minimal}{\let\UM@aftertitle\UM@printcopyright}{}

\endinput
