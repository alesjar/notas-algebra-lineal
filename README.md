# Hubbard-style mathematics book template

This is an independent LaTeX implementation of the visible interior design
in the supplied fifth-edition scan of *Vector Calculus, Linear Algebra,
and Differential Forms: A Unified Approach*, by John H. Hubbard and
Barbara Burke Hubbard. It is not the publisher's original source or class.
The sample mathematical text and diagrams are original.

## Start writing

1. Keep `hubbardbook.cls` beside `book.tex`.
2. Edit the title and author in `book.tex`.
3. Replace `chapters/chapter01.tex` with your first chapter. Add more chapter
   files and include them using `\include{chapters/chapter02}`, etc.
4. Compile **book.tex** with **pdfLaTeX**, at least twice:

```sh
pdflatex book.tex
pdflatex book.tex
```

Or let latexmk handle the necessary reruns:

```sh
latexmk -pdf book.tex
```

`example.tex` is the longer design specimen. Its compiled output is
`example.pdf`. The explicit page breaks in that specimen are demonstration
layout choices; you do not need them in your manuscript.

For Overleaf, upload the ZIP, choose `book.tex` as the main document, and
select pdfLaTeX. The class uses standard packages distributed with TeX Live
and MiKTeX. No custom fonts, external images, shell escape, or proprietary
packages are required. TikZ is used only in the example, not in the starter.

## Verified fonts, and what is approximate

The publisher's [digital Chapter 0 sample](https://matrixeditions.com/VC5.Chap0.pdf)
and [theorem sample](https://matrixeditions.com/5vec.onepage.pdf) retain their
embedded fonts. Inspection confirms **Computer Modern Roman (CMR10)** for
ordinary body text and **CMR9** for margin notes. These are the families used
by this class, not Times Roman. The uploaded scan's OCR names refer to its
recognition layer and do not identify the original typesetting.

Version 1.1 corrects the variants used for headings and theorems after checking
those digital samples. Chapter numbers use **CMB10 at 24 PDF points**, chapter
titles **CMB10 at 20**, section headings **CMCSC10 at 14**, and subsection
headings **CMB10 at 12**. This is the bold series (`b`), distinct from the bold
extended series (`bx`) ordinarily selected by `\bfseries`. Statement headings
remain CMBX10. Theorem bodies now use **CMSL10**, slanted Roman, rather than
**CMTI10**, the italic used in version 1.0. Italic emphasis remains appropriate
in ordinary prose.

The uploaded scan looks substantially heavier than the publisher's digital
sample even in ordinary body text. Printing, rasterization, and scan processing
are plausible causes of this difference; it is not evidence for a different
body font family. The class does not artificially thicken Computer Modern.
The publisher's body size is 10 PDF points; LaTeX's nominal 10 TeX points are
about 9.963 PDF points. That small difference is retained for standard LaTeX
body-size behavior; heading sizes above use PDF points explicitly.

The interior PDF page measures about 523.2 by 651.24 PDF points (184.57 by
229.74 mm). These are the scan's page dimensions, not an independently
verified physical trim size. Margins and type sizes below are a measured
approximation, with minor optical adjustment.

| Element | Default setting |
|---|---|
| Body font | Computer Modern, 10 pt with 12 pt baseline spacing |
| Main text | About 324.2 bp wide; begins 174 bp from the left edge |
| Note column | 140 bp wide, with a 12 bp gap before the main text |
| Note placement | Left side on **both** odd and even pages |
| Note type | 9 pt with 10.8 pt baseline spacing; justified |
| Chapters | CMB10: 24 bp number on a separate line; 20 bp title |
| Sections | CMCSC10 at 14 bp, slightly outdented |
| Subsections | CMB10 at 12 bp, unnumbered |
| Running heads | Page/chapter on even pages; section/page on odd pages |
| Statements | Bold heading, slightly inset body, no border by default |
| Theorem bodies | CMSL10, slanted Roman |
| Numbering | Shared statement sequence; separate equations and figures |
| Equation tags | `1.2.3`, without parentheses |
| End marks | Square for proofs; triangle for examples |

The uploaded scan shows **unframed** statement blocks. The publisher's digital
theorem sample also reveals pale gray shading that is lost in the scan. This
class keeps the scan's white default; use `\tcbset{hbstatement/.append style=
{colback=black!8}}` in the preamble for pale gray statement backgrounds.
Framed and separately titled shaded boxes are additional authoring options.
Exact line breaks, scan imperfections, and the publisher's manually adjusted
page composition are not reproduced.

## Commands and environments

### Chapter structure

```latex
\chapter{Vectors and linear maps}
\chapterepigraph{An optional quotation.}{Attribution}
\introsection                 % 1.0 Introduction; use only at chapter start
\section{Vectors and length}  % 1.1
\subsection{A geometric interpretation} % bold, unnumbered
```

Use `\introsection[An alternative introduction title]` for another title.
Omit `\introsection` if your sections should begin at 1.1. To begin the
book with Chapter 0, put `\setcounter{chapter}{-1}` immediately before
the first `\chapter` or chapter `\include`.

### Margin notes

```latex
\sidenote{An unnumbered explanation in the left margin.}
This is the relevant main-text paragraph.

\sidenote[18pt]{This note starts 18 points lower.}
\sidenote[-8pt]{This note starts 8 points higher.}

\numberedsidenote{A superscript marker in the text and in the note.}

\autonote{A floating note that can move down to avoid other floating notes.}
```

Place an anchored note beside the sentence it explains, preferably at the
start of a paragraph. `\sidenote` uses `marginnote`: it preserves the
anchor position but **does not detect overlaps or split a long note over
pages**. Move the anchor or adjust its optional offset after proofreading.
Margin figures have the same placement behavior. Do not use a note taller
than the available page space.

`\autonote` uses LaTeX's floating `\marginpar`: it attempts to avoid other
floating margin notes by moving down. It does not coordinate with anchored
notes, does not split long notes, and may produce placement warnings near
the bottom of a crowded page. Use one placement strategy within any dense
group of annotations.

Put a note for a theorem immediately **before** the theorem environment,
not inside the statement box. This avoids a dependency on how a long box
is split at a page boundary. Do not place note commands in chapter titles,
section titles, captions, or other moving arguments.

To change note typography in your preamble:

```latex
\renewcommand{\sidenotefont}{\normalfont\fontsize{8.5}{10.5}\selectfont}
```

### Theorems, definitions, examples, proofs

```latex
\begin{definition}[Linear map]\label{def:linear}
Your definition.
\end{definition}

\begin{theorem}[A descriptive title]\label{thm:main}
Your theorem statement.
\end{theorem}

\begin{proof}
Your proof.
\end{proof}

\begin{example}[An example]
Your example. % A triangle is added automatically at the end.
\end{example}

See Theorem~\ref{thm:main}.
```

Available numbered environments are `theorem`, `lemma`, `proposition`,
`corollary`, `definition`, `example`, `remark`, `boxedtheorem`, and
`boxeddefinition`. They share one counter, reset by section. The theorem
family has slanted Roman bodies; definitions, remarks, and examples have upright
bodies. `theorem*`, `definition*`, and `remark*` are unnumbered.

The `boxed...` environments add a thin rectangular border. Default statements
and framed statements can break across pages. If a proof or example ends in
a displayed equation, use `\qedhere` inside the display to position its end mark.

### Text boxes

```latex
\begin{textblock}{Key idea}
An unframed, inset text block, closest to the reference's statement style.
\end{textblock}

\begin{textbox}{Remember}
A box with a thin black frame. Multiple paragraphs and equations are allowed.
\end{textbox}

\begin{shadedbox}{Common mistake}
A framed box with a light gray background.
\end{shadedbox}

% Optional arguments are standard tcolorbox keys:
\begin{textbox}[colback=black!3,boxrule=0.6pt]{Custom box}
Your text.
\end{textbox}
```

For an untitled box, pass an empty title: `\begin{textbox}{}`.
These are breakable text boxes. Do not nest floating `figure` or `table`
environments inside them. A regular `tabular`, equation, or list is fine.

### Equations

```latex
\begin{equation}\label{eq:linearity}
  T(au+bv)=aT(u)+bT(v).
\end{equation}
See equation~\ref{eq:linearity}.
```

Equation numbers reset by section and are printed without parentheses, as
in the reference. In this class `\eqref` also follows that bare-number style;
write `(\ref{eq:linearity})` when parentheses are specifically wanted.
Use `\(...\)` for inline math and `\[...\]` for unnumbered displays.

### Margin figures and tables

```latex
\begin{marginfigure}[10pt]
  \centering
  \includegraphics[width=\linewidth]{figures/my-diagram.pdf}
  \caption{A short explanation.}
  \label{fig:margin}
\end{marginfigure}
```

The optional argument is a vertical offset, **not** a float specifier.
Place `\label` after `\caption`. The environment does not float and shares
the ordinary figure counter. `margintable` works similarly with a `tabular`
and a table caption. Keep diagrams within `\linewidth`.

### Main-column and full-width figures

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=\linewidth]{figures/my-diagram.pdf}
  \caption{A figure in the main text column.}
  \label{fig:main}
\end{figure}

\begin{fullwidth}
  \centering
  \includegraphics[width=\linewidth]{figures/wide-diagram.pdf}
  \captionof{figure}{A figure extending across the note column.}
  \label{fig:wide}
\end{fullwidth}
```

`fullwidth` extends left into the note column and keeps its contents together
in a minipage. Keep it shorter than one page. Do not place a margin note in
the same vertical area. Use it at the top level, not inside a list or statement
box. For a floating wide figure, put the `fullwidth` environment inside a
normal `figure` environment. With a nonfloating `\captionof`, you may set
`\captionsetup{hypcap=false}` before the caption to avoid a harmless warning
about the hyperlink target.

### Exercises

```latex
\begin{exercises}
  \begin{exercise}\label{ex:first}
    State and prove a useful result.
  \end{exercise}
  \begin{exercise}[An optional title]
    \begin{enumerate}[label=\alph*.]
      \item First part.
      \item Second part.
    \end{enumerate}
  \end{exercise}
\end{exercises}
```

Exercises have their own section-based counter. A small-cap heading,
smaller type, and closing horizontal rule echo the reference.

## Font, language, and paper options

```latex
\documentclass{hubbardbook} % default: Computer Modern and scan-sized pages
\documentclass[modernfonts]{hubbardbook} % Latin Modern + T1 encoding
\documentclass[a4paper,modernfonts]{hubbardbook} % roomier A4 layout
```

Use one `\documentclass` line, not all three. The `modernfonts` option is a
close Computer Modern derivative with T1 encoding, convenient for accented
European languages. It is an explicit alternative, not the exact same font.
The A4 option keeps a fixed left sidebar but changes the reference geometry.

For Spanish, add `\usepackage[spanish]{babel}` after the class declaration.
The class's theorem names are currently English. You can define additional
localized environments sharing the same counter in your preamble:

```latex
\theoremstyle{hbplain}
\newtheorem{teorema}[theorem]{Teorema}
\tcolorboxenvironment{teorema}{hbstatement}
\theoremstyle{hbdefinition}
\newtheorem{definicion}[theorem]{Definici\'on}
\tcolorboxenvironment{definicion}{hbstatement}
```

For a different page size, edit the geometry block in `hubbardbook.cls` or
call `\geometry{...}` in the preamble. Keep `asymmetric` and the left
sidebar unless you intentionally want a different design. In `geometry`,
the large left margin includes the sidebar; do not add `includemp` to these
settings, which would count the note column a second time.

The class handles the layout; you can add bibliography, index, notation,
or subject-specific packages in your manuscript. Avoid loading competing
font, theorem, page-layout, or heading packages without checking their
interaction with the class.

## Validation

The starter and the six-page specimen were compiled with pdfLaTeX (TeX Live
2023), with all references resolved and no compilation warnings. The rendered
specimen was visually checked. A separate check covered the A4 and Latin Modern
options, accented text, a margin table, appendix numbering, end-of-proof marks
in displays, and a framed box continuing across multiple pages. Version 1.1
was recompiled and visually reviewed after the publisher-verified changes to
heading fonts and slanted theorem bodies.
