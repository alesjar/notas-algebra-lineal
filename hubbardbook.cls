%% hubbardbook.cls -- an independent approximation of the Hubbard book layout.
%% This is not the publisher's original class. Compile with pdfLaTeX.
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{hubbardbook}[2026/09/20 v1.1 Publisher-verified Computer Modern variants]

% Options: modernfonts selects Latin Modern with T1 encoding; a4paper changes
% the page geometry. Other options are passed to the standard book class.
\newif\ifhb@modernfonts
\newif\ifhb@afour
\DeclareOption{modernfonts}{\hb@modernfontstrue}
\DeclareOption{a4paper}{\hb@afourtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\RequirePackage{fix-cm}
\LoadClass[10pt,twoside,openany]{book}
\RequirePackage[utf8]{inputenc}
\ifhb@modernfonts
  \RequirePackage[T1]{fontenc}
  \RequirePackage{lmodern}
\fi
% Otherwise retain the standard Computer Modern text and math fonts.
% Font evidence: matrixeditions.com/VC5.Chap0.pdf and 5vec.onepage.pdf.
% Body CMR10; margin CMR9; chapter/subsection headings CMB10;
% statement heads CMBX10; theorem bodies CMSL10 (slanted, not italic).
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\RequirePackage{microtype}
\RequirePackage{xparse}
\RequirePackage{geometry}
\ifhb@afour
  \geometry{a4paper,asymmetric,left=62mm,right=18mm,
    top=20mm,bottom=23mm,marginparwidth=43mm,marginparsep=6mm,
    headheight=12pt,headsep=12pt,footskip=24pt}
\else
  % Measurements approximate the scanned interior pages, NOT an inferred
  % physical trim size. bp is a PDF point (1/72 inch).
  \geometry{paperwidth=523.2bp,paperheight=651.24bp,asymmetric,
    left=174bp,right=25bp,top=36bp,bottom=40bp,
    marginparwidth=140bp,marginparsep=12bp,
    headheight=12bp,headsep=12bp,footskip=24bp}
\fi
\reversemarginpar
\setlength{\parindent}{12pt}
\setlength{\parskip}{0pt}
\setlength{\marginparpush}{8pt}
\setlength{\emergencystretch}{1em}
\raggedbottom

% Headings: a number on its own line for chapters; small-cap sections;
% unnumbered, bold subsections. A slight outdent matches the source.
\RequirePackage{titlesec}
\setcounter{secnumdepth}{1}
\setcounter{tocdepth}{1}
\newcommand{\bookheadingfont}{\fontseries{b}\selectfont}
\titleformat{\chapter}[display]
  {\normalfont\fontsize{20bp}{24bp}\selectfont\bookheadingfont}
  {\fontsize{24bp}{28bp}\selectfont\thechapter}{5pt}{}
\titlespacing*{\chapter}{-16bp}{-8pt}{20pt}
\titleformat{\section}
  {\normalfont\fontsize{14bp}{17bp}\selectfont\scshape}
  {\thesection}{0.7em}{}
\titlespacing*{\section}{-16bp}{22pt plus 3pt minus 2pt}{9pt}
\titleformat{\subsection}
  {\normalfont\fontsize{12bp}{14.5bp}\selectfont\bookheadingfont}{}{0pt}{}
\titlespacing*{\subsection}{0pt}{13pt plus 2pt minus 1pt}{6pt}
\titleformat{\subsubsection}[runin]{\normalfont\bfseries}{}{0pt}{}[.]
\titlespacing*{\subsubsection}{0pt}{9pt}{0.5em}
\NewDocumentCommand{\introsection}{O{Introduction}}{%
  \setcounter{section}{-1}\section{#1}}
\NewDocumentCommand{\chapterepigraph}{m m}{%
  \begin{flushright}\begin{minipage}{0.88\linewidth}
    \small\itshape #1\par\smallskip
    \normalfont\raggedleft #2
  \end{minipage}\end{flushright}\medskip}

% Running heads remain over the main text column, on both page parities.
\RequirePackage{fancyhdr}
\RequirePackage{emptypage}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\chaptermark}[1]{%
  \markboth{\ifnum\c@secnumdepth>\m@ne
    \if@mainmatter\chaptername\ \thechapter.\quad\fi\fi #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
\fancyhead[LE]{\normalfont\footnotesize\thepage\quad\nouppercase{\leftmark}}
\fancyhead[RO]{\normalfont\footnotesize\nouppercase{\rightmark}\quad\thepage}
\fancypagestyle{plain}{%
  \fancyhf{}\fancyfoot[C]{\normalfont\footnotesize\thepage}
  \renewcommand{\headrulewidth}{0pt}}

% Margin notes. Unlike a conventional mirrored book, ALL notes stay left.
% marginnote uses its own twoside switch, separate from geometry's switch.
\RequirePackage{marginnote}
\RequirePackage{ragged2e}
\newcommand{\sidenotefont}{\normalfont\fontsize{9}{10.8}\selectfont}
\renewcommand*{\marginfont}{\sidenotefont}
\newcommand{\hb@marginparagraphs}{%
  \justifying\setlength{\parindent}{10pt}\setlength{\parskip}{4pt}}
\renewcommand*{\raggedleftmarginnote}{\hb@marginparagraphs}
\renewcommand*{\raggedrightmarginnote}{\hb@marginparagraphs}
\NewDocumentCommand{\sidenote}{O{0pt} +m}{%
  \begingroup\@twosidefalse\reversemarginpar
    \marginnote{#2}[#1]%
  \endgroup}
% A floating alternative that moves notes down to avoid other floating notes.
% Do not mix it with anchored notes in a densely annotated area.
\NewDocumentCommand{\autonote}{+m}{%
  \marginpar{\sidenotefont\hb@marginparagraphs #1}}
\newcounter{sidenote}[chapter]
\NewDocumentCommand{\numberedsidenote}{O{0pt} +m}{%
  \refstepcounter{sidenote}\textsuperscript{\thesidenote}%
  \sidenote[#1]{\textsuperscript{\thesidenote}\,#2}}

% Figures and a non-floating marginfigure environment.
\RequirePackage{graphicx}
\RequirePackage{caption}
\DeclareCaptionFont{hbcaption}{\fontsize{9}{11}\selectfont}
\captionsetup{font=hbcaption,labelfont=sc,labelsep=period,
  justification=justified,singlelinecheck=false,skip=6pt}
\numberwithin{figure}{section}
\numberwithin{table}{section}
\NewDocumentCommand{\hb@objectnote}{O{0pt} +m}{%
  \begingroup
    \renewcommand{\hb@marginparagraphs}{%
      \justifying\setlength{\parindent}{0pt}\setlength{\parskip}{4pt}}%
    \sidenote[#1]{#2}%
  \endgroup}
\NewDocumentEnvironment{marginfigure}{O{0pt} +b}{%
  \hb@objectnote[#1]{\begin{minipage}{\marginparwidth}
    \captionsetup{type=figure,font=hbcaption,labelfont=sc,
      labelsep=period,justification=justified,singlelinecheck=false}
    #2
  \end{minipage}}%
}{}
\NewDocumentEnvironment{margintable}{O{0pt} +b}{%
  \hb@objectnote[#1]{\begin{minipage}{\marginparwidth}
    \captionsetup{type=table,font=hbcaption}#2
  \end{minipage}}%
}{}
\RequirePackage{changepage}
\NewDocumentEnvironment{fullwidth}{}{%
  \begin{adjustwidth}{\dimexpr-\marginparwidth-\marginparsep\relax}{0pt}%
  \noindent\begin{minipage}{\linewidth}%
}{\end{minipage}\end{adjustwidth}}

% Equations have section-based numbers without printed parentheses.
\numberwithin{equation}{section}
\renewcommand*{\tagform@}[1]{\maketag@@@{\ignorespaces#1\unskip\@@italiccorr}}

% Shared theorem/definition/example numbering: 1.1.1, 1.1.2, ...
\newtheoremstyle{hbplain}{0pt}{0pt}{\slshape}{}%
  {\bfseries}{.}{0.6em}{\thmname{#1}\thmnumber{ #2}\thmnote{ \textbf{(#3)}}}
\newtheoremstyle{hbdefinition}{0pt}{0pt}{\normalfont}{}%
  {\bfseries}{.}{0.6em}{\thmname{#1}\thmnumber{ #2}\thmnote{ \textbf{(#3)}}}
\newtheoremstyle{hbexample}{8pt}{8pt}{\normalfont}{}%
  {\bfseries}{.}{0.6em}{\thmname{#1}\thmnumber{ #2}\thmnote{ \textbf{(#3)}}}
\theoremstyle{hbplain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{boxedtheorem}[theorem]{Theorem}
\newtheorem*{theorem*}{Theorem}
\theoremstyle{hbdefinition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{boxeddefinition}[theorem]{Definition}
\newtheorem*{definition*}{Definition}
\theoremstyle{hbexample}
\newtheorem{hb@example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}
\newtheorem*{remark*}{Remark}
\NewDocumentEnvironment{example}{o}{%
  \renewcommand{\qedsymbol}{\(\triangle\)}\pushQED{\qed}%
  \IfNoValueTF{#1}{\begin{hb@example}}{\begin{hb@example}[#1]}%
}{\popQED\end{hb@example}}
\renewenvironment{proof}[1][\proofname]{%
  \par\pushQED{\qed}\normalfont\topsep6pt\relax
  \trivlist\item[\hskip\labelsep\bfseries #1.]\ignorespaces
}{\popQED\endtrivlist\@endpefalse}

% The source's ordinary statement blocks are UNFRAMED and slightly inset.
% Framed and shaded boxes below are optional conveniences for the author.
\RequirePackage[most]{tcolorbox}
\tcbset{
  hbstatement/.style={enhanced,breakable,frame hidden,colback=white,
    boxrule=0pt,sharp corners,boxsep=0pt,left=6pt,right=6pt,
    top=0pt,bottom=0pt,before skip=9pt,after skip=9pt},
  hbframe/.style={enhanced,breakable,colback=white,colframe=black,
    boxrule=0.4pt,sharp corners,boxsep=0pt,left=7pt,right=7pt,
    top=6pt,bottom=6pt,before skip=10pt,after skip=10pt},
  hbtitle/.style={fonttitle=\normalfont\bfseries,coltitle=black,
    colbacktitle=white,attach title to upper={.\enspace}}
}
\tcolorboxenvironment{theorem}{hbstatement}
\tcolorboxenvironment{lemma}{hbstatement}
\tcolorboxenvironment{proposition}{hbstatement}
\tcolorboxenvironment{corollary}{hbstatement}
\tcolorboxenvironment{definition}{hbstatement}
\tcolorboxenvironment{theorem*}{hbstatement}
\tcolorboxenvironment{definition*}{hbstatement}
\tcolorboxenvironment{boxedtheorem}{hbframe}
\tcolorboxenvironment{boxeddefinition}{hbframe}
\NewTColorBox{textblock}{O{} m}{hbstatement,hbtitle,title={#2},#1}
\NewTColorBox{textbox}{O{} m}{hbframe,hbtitle,title={#2},#1}
\NewTColorBox{shadedbox}{O{} m}{hbframe,hbtitle,
  colback=black!5,title={#2},#1}

% Section exercises, separately numbered from statements and equations.
\RequirePackage{enumitem}
\setlist{nosep,leftmargin=*,topsep=4pt}
\newcounter{exercise}[section]
\renewcommand{\theexercise}{\thesection.\arabic{exercise}}
\NewDocumentEnvironment{exercises}{}{%
  \section*{Exercises for Section \thesection}\small
}{\par\medskip\hrule\medskip}
\NewDocumentEnvironment{exercise}{o}{%
  \par\addvspace{6pt}\refstepcounter{exercise}\noindent
  \textbf{\theexercise}%
  \IfNoValueF{#1}{\ \textbf{(#1)}}\quad\ignorespaces
}{\par}

% Hyperlinks work with ordinary \label / \ref commands in every environment.
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}
\endinput
