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

% The lab styles (labcard, labband, masthead) carry the lab wordmark and use no
% coloured edge bars anywhere, including the takeaway box. card, band and rule
% keep their original look.
\newif\ifUM@labstyle
\ifdefstring\UM@titlestyle{labcard}{\UM@labstyletrue}{}
\ifdefstring\UM@titlestyle{labband}{\UM@labstyletrue}{}
\ifdefstring\UM@titlestyle{masthead}{\UM@labstyletrue}{}
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
\newcommand\UM@marks[1]{{\sffamily\mdseries\let\dagger\textdagger
  \let\ddagger\textdaggerdbl #1}}

\newcommand\UM@title{}
\renewcommand\title[1]{\renewcommand\UM@title{#1}}
\newcommand\UM@runningtitle{}
\newcommand\runningtitle[1]{\renewcommand\UM@runningtitle{#1}}
\newcommand\UM@reportlabel{Preprint}
\newcommand\reportlabel[1]{\renewcommand\UM@reportlabel{#1}}

\newcommand\UM@authors{}
\renewcommand\author[2][]{\UM@additem\UM@authors{, }%
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
\renewcommand\date[1]{\metadata[Date][\faCalendar*]{#1}}
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
\newcommand\UM@printmetadatainline{\ifdefempty\UM@metadata{}{{\sffamily
  \fontsize{8.5}{14}\selectfont\raggedright
  \def\UM@metasep{\hspace{1.8em plus 0.8em}\allowbreak}\let\UM@metahang\relax
  \UM@metadata\par}}}

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

% \maketitle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\UM@maketitle{%
  \setlength\parskip{0pt}\setlength\parindent{0pt}%
  \ifcsname UM@maketitle@\UM@titlestyle\endcsname
    \csname UM@maketitle@\UM@titlestyle\endcsname
  \else
    \ClassError{udemmila}{Unknown titlestyle `\UM@titlestyle'}%
      {Use titlestyle=card, band, rule, labcard, labband or masthead.}%
  \fi}
\renewcommand\maketitle{%
  \thispagestyle{UMfirst}%
  \if@twocolumn
    \twocolumn[{\UM@maketitle}\vspace{7mm}]%
  \else
    {\UM@maketitle\par}\vspace{6mm}%
  \fi
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

\endinput
