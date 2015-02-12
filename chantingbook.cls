% Chantingbook Class
%
% A memoir-based documentclass for a chanting book.
%
% (c) Gambhiro Bhikkhu, 2015
% gambhiro.bhikkhu.85@gmail.com
%
% LPPL LaTeX Pubic Project Licence
%

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chantingbook}[2015/01/26 v0.1 A memoir-based documentclass for a chanting book.]

% ========================
% Preliminary Declarations
% ========================

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/BOOK}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

\LoadClass[11pt,twoside]{memoir}

% === Book Core ===

\RequirePackage[british]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
%\RequirePackage{textcomp}
\RequirePackage[cmyk]{xcolor}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
%\RequirePackage{eso-pic}
%\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{tikz}
\usetikzlibrary{positioning}

% === Define colors ===

\definecolor{textbody}{gray}{0.15}
\definecolor{header}{gray}{0.4}
\definecolor{pagenum}{gray}{0.2}
\definecolor{chaptertitle}{gray}{0.2}
\definecolor{chapterrule}{gray}{0.2}

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./fonts/}, }

\setmainfont[
  ItalicFont=GentiumPlus-I.ttf,
  BoldFont=GenBkBasB.ttf,
  BoldItalicFont=GenBkBasBI.ttf,
  StylisticSet=2,
]{GentiumIncantation-Regular.ttf}

%\newcommand\partTitleFont{}

\newfontfamily\AlegreyaSans{AlegreyaSans-Regular.otf}
\newfontfamily\AlegreyaSansSC{AlegreyaSansSC-Regular.otf}
\newfontfamily\UbuntuMedium{Ubuntu-M.ttf}

\newfontfamily\headerFont[
  BoldFont=AlegreyaSansSC-Bold.otf,
  LetterSpace=5.0,
]{AlegreyaSansSC-Regular.otf}

\newfontfamily\pageNumFont[
  BoldFont=AlegreyaSansSC-Bold.otf,
  LetterSpace=5.0,
  Numbers=Lining,
]{AlegreyaSansSC-Regular.otf}

\newfontfamily\chapterTitleFont{Ubuntu-M.ttf}

\newfontfamily\instructionFont[
  BoldFont=AlegreyaSansSC-Bold.otf,
  LetterSpace=3.0,
]{AlegreyaSansSC-Regular.otf}

% font sizes

\newcommand{\chapterTitleSize}
{\@setfontsize\chapterTitleSize{17}{20}}

\newcommand{\headerSize}
  {\@setfontsize\headerSize{12}{12}}
\newcommand{\pageNumSize}
  {\@setfontsize\pageNumSize{17}{17}}

% === microtype ===

\RequirePackage[final,babel=true]{microtype}
%\SetTracking[spacing={500,100,}]{encoding=*, family=chapterTitleFont}{40}

% === hyperref ===

\RequirePackage{hyperref}

\hypersetup{
  colorlinks=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody,
  unicode=true,
}

\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% === penalties and hyphenation ===

% memoir's more allowing penalties
\midsloppy

\renewcommand\britishhyphenmins{{3}{3}}

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
%\finalhyphendemerits=5000 % default is 5000
\brokenpenalty=990

\RequirePackage[defaultlines=2,all]{nowidow}

% === common hyphenation exceptions and corrections ===

\hyphenation{season wisdom develop-ment respon-sible pheno-mena
philo-sophical munindo amaravati thai-land}

% === soul settings ===

% === Page geometry and layout ===

% === normalsize ===

\def\BOOK@fontSizePt{12.5}
\def\BOOK@lineHeightPt{21}

\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\BOOK@fontSizePt\BOOK@lineHeightPt
  \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}
\normalsize

\def\BOOK@readingFontSizePt{11.5}
\def\BOOK@readingLineHeightPt{20}

\newcommand{\readingsize}{%
  \@setfontsize\readingsize\BOOK@readingFontSizePt\BOOK@readingLineHeightPt
  \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}

% === indentations ===

\setlength{\vgap}{1.5em}
\setlength{\vindent}{\vgap}
\setlength{\vleftmargin}{2em}

\setlength{\parskip}{5pt}
\setlength{\parindent}{0pt}

% === setup page layout ===

%\setstocksize{250mm}{185mm}% 1.35, Nicholas
\setstocksize{250mm}{181mm}% 1.376, Short Pentagon
\settrimmedsize{\stockheight}{\stockwidth}{*}
\settrims{0pt}{0pt}
\settypeblocksize{200mm}{*}{0.618}% 1/1.618, Golden section, ~126.7mm
\setlrmargins{*}{*}{1.618}
\setulmargins{*}{*}{1.618}
\setheaderspaces{*}{*}{1.618}
%\setlength{\footskip}{3\baselineskip}

% This will also typeout values in pt (default)
\checkandfixthelayout
% It is useful to see layout values in mm too.
\settypeoutlayoutunit{mm}
\typeoutlayout

% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newlength\BOOK@headWidth
\setlength{\BOOK@headWidth}{\textwidth + 2\foremargin}

\makepagestyle{toprightnum}
\makerunningwidth{toprightnum}[\textwidth]{\BOOK@headWidth}

\makepsmarks{toprightnum}{%
  \def\chaptermark##1{%
    \markboth{##1}{\rightmark}}%
  \def\partmark##1{%
    \markright{##1}{}}%
  \let\sectionmark\@gobble
}

\makeoddhead{toprightnum}%
{\headerFont\headerSize\color{header}\hspace*{\foremargin}\MakeLowercase{\rightmark}}%
{}%
{\headerFont\headerSize\color{header}%
  \MakeLowercase{\leftmark}%
  \parbox[c][][t]{\foremargin}{%
    \pageNumFont\pageNumSize\color{pagenum}%
    \mbox{}\hfill\textbf{\thepage}\hfill\mbox{}%
  }%
}

\makeevenhead{toprightnum}%
{\headerFont\headerSize\color{header}%
  \parbox[c][][t]{\foremargin}{%
    \pageNumFont\pageNumSize\color{pagenum}%
    \mbox{}\hfill\textbf{\thepage}\hfill\mbox{}%
  }%
  \MakeLowercase{\leftmark}%
}%
{}%
{\headerFont\headerSize\color{header}\MakeLowercase{\rightmark}\hspace*{\foremargin}}

\makeoddfoot{toprightnum}{}{}{}
\makeevenfoot{toprightnum}{}{}{}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{toprightnum}
\aliaspagestyle{chapter}{toprightnum}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

% === TOC settings ===

\maxtocdepth{section}

% === Book styles ===

% === Part styles ===

% === Chapter styles ===

\setsecnumdepth{chapter}

% define chapter styles with "fantasy" names

\newlength\tmp@a

\makechapterstyle{diamondleft}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{0pt}
  \setlength{\afterchapskip}{1.5\onelineskip}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\printchapternum{}
  \renewcommand\afterchapternum{}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand*\printchaptertitle[1]{%
    \begin{minipage}{\linewidth}%
      \raggedright\chapterTitleSize\color{chapterrule}%

      %% One diamond, on the line.
      %\rule[0pt]{\linewidth}{0.6pt}%
      %\vskip -\baselineskip\vskip -0.3pt\vskip 1.8pt\hskip 20pt%
      %\rotatebox[origin=c]{45}{\rule{3.6pt}{3.6pt}}%
      %\newline%

      %% Three diamonds, with slight gap b/w the line.
      \setlength{\tmp@a}{\leaderIndent}%
      \rule{\tmp@a}{0.6pt}%
      \addtolength{\tmp@a}{2pt}%
      \vskip -\baselineskip\vskip -0.3pt\vskip 1.8pt\hskip \tmp@a%
      \resizebox{15pt}{!}{% have to resize, b/c rotated diamonds will line up by diagonal, not by side-width
        \rotatebox[origin=c]{45}{\rule{4pt}{4pt}}%
        \rotatebox[origin=c]{45}{\rule{4pt}{4pt}}%
        \rotatebox[origin=c]{45}{\rule{4pt}{4pt}}%
      }%
      \addtolength{\tmp@a}{17pt}%
      \vskip -\baselineskip\vskip -1.5pt\hskip \tmp@a%
      \rule{\linewidth - \tmp@a}{0.6pt}%

      \chaptitlefont\color{chaptertitle}%
      %\textls*{\MakeUppercase{##1}}%
      ##1%
    \end{minipage}%
  }
}

\makechapterstyle{innerpenstroke}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{0pt}
  %\setbeforesecskip{-3.5ex \@plus -1ex \@minus -.2ex}
  %\setbeforesecskip{-1\onelineskip
  %                  \@plus -0.5\onelineskip \@minus -.5\onelineskip}%
  \setlength{\afterchapskip}{1.5\onelineskip}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\printchapternum{}
  \renewcommand\afterchapternum{}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand*\printchaptertitle[1]{%
    \begin{minipage}{\linewidth}%
      \raggedright
      \chaptitlefont\color{chaptertitle}%
      %\textls*{\MakeUppercase{##1}}%
      ##1%
    \end{minipage}%
  }
}
% Commands to assign the chapter styles to book parts. Use \renewcommand
% to adjust.

%\newcommand\frontmatterChapterStyle{\chapterstyle{hightitle}}
\newcommand\mainmatterChapterStyle{\chapterstyle{innerpenstroke}}
%\newcommand\appendixChapterStyle{\chapterstyle{hightitle}}
%\newcommand\backmatterChapterStyle{\chapterstyle{hightitle}}
%
%% append them to the macros

%\addtodef{\frontmatter}{}{\frontmatterChapterStyle}

\addtodef{\mainmatter}{}{
  \setcounter{chapter}{0}
  \mainmatterChapterStyle
  \raggedright
  \openany
  \gdef\clearforchapter{\relax}
}

\addtodef{\appendix}{}{
  %\appendixChapterStyle
  \bookmarksetup{startatroot}
  \openright
}

\addtodef{\backmatter}{}{
  %\backmatterChapterStyle
  \bookmarksetup{startatroot}
}

% === Section styles ===

\raggedbottomsection

% === Custom commands and environments ===

% Cantillation marks

\newcommand*\cU[1]{#1\symbol{"F010}}
\newcommand*\cD[1]{#1\symbol{"F011}}
\newcommand*\cDL[1]{#1\symbol{"F012}}

%\newenvironment{quotation}%
%               {\list{}{\listparindent 1.5em%
%                        \itemindent    \listparindent
%                        \rightmargin   \leftmargin
%                        \parsep        \z@ \@plus\p@}%
%                \item[]}%
%               {\endlist}

\newlength\leaderIndent
\setlength{\leaderIndent}{\widthof{\normalsize\hspace*{1.8em}}}
\newlength\bracketWidth
\setlength{\bracketWidth}{\widthof{\normalsize [}}

\newenvironment{leader}%
  {\list{}{\listparindent 0em%
  \itemindent    0pt
  %\itemindent    -\bracketWidth
  \leftmargin    \leaderIndent
  \rightmargin   \leaderIndent
  \parsep        12pt
  %\parsep        \z@ \@plus\p@%
  }
  \item[] \raggedright}%
  {\endlist}

\newenvironment{english}%
  {\list{}{\listparindent 0em%
  \itemindent    0em
  \leftmargin    \leaderIndent
  \rightmargin   0em
  \parsep        \z@ \@plus\p@}%
  \item[] \raggedright\itshape}%
  {\endlist}

\newcommand{\instr}[1]{%
  {\instructionFont\color[gray]{0.5}\bfseries%
  [\space\MakeLowercase{#1}\space]}%
}

\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

%% http://tex.stackexchange.com/questions/36894/underline-omitting-the-descenders

%% http://tex.stackexchange.com/a/67008

%\makeatletter
%
%\ExplSyntaxOn
%\cs_new:Npn \white_text:n #1
%  {
%    \fp_set:Nn \l_tmpa_fp {.01}
%    \fp_mul:Nn \l_tmpa_fp {#1}
%    \llap{\textcolor{white}{\the\SOUL@syllable}\hspace{\fp_to_decimal:N \l_tmpa_fp em}}
%    \llap{\textcolor{white}{\the\SOUL@syllable}\hspace{-\fp_to_decimal:N \l_tmpa_fp em}}
%  }
%\NewDocumentCommand{\whiten}{ m }
%    {
%      \int_step_function:nnnN {1}{1}{#1} \white_text:n
%    }
%\ExplSyntaxOff
%
%\NewDocumentCommand{ \varul }{ D<>{5} O{0.2ex} O{0.1ex} +m } {%
%\begingroup
%\setul{#2}{#3}%
%\def\SOUL@uleverysyllable{%
%   \setbox0=\hbox{\the\SOUL@syllable}%
%   \ifdim\dp0>\z@
%      \SOUL@ulunderline{\phantom{\the\SOUL@syllable}}%
%      \whiten{#1}%
%      \llap{%
%        \the\SOUL@syllable
%        \SOUL@setkern\SOUL@charkern
%      }%
%   \else
%       \SOUL@ulunderline{%
%         \the\SOUL@syllable
%         \SOUL@setkern\SOUL@charkern
%       }%
%   \fi}%
%    \ul{#4}%
%\endgroup
%}
%
%\makeatother

%% http://tex.stackexchange.com/a/75406

\RequirePackage[outline]{contour}

\usepackage{ulem}
\normalem % use classical emph

\newcommand\prul[1]{%
  \begingroup%
  \renewcommand{\ULdepth}{1.8pt}%
  \renewcommand{\ULthickness}{0.5pt}%
  \contourlength{0.5pt}%
  \uline{\phantom{#1}}\llap{\contour{white}{#1}}%
  \endgroup%
}

%\newcommand \myul[4]{%
%  \begingroup%
%  \renewcommand \ULdepth {#1}%
%  \renewcommand \ULthickness {#2}%
%  \contourlength{#3}%
%  \uline{\phantom{#4}}\llap{\contour{white}{#4}}%
%  \endgroup%
%}

%\newcommand \myulline[4]{%
%  \begingroup%
%  \renewcommand \ULdepth {#1}%
%  \renewcommand \ULthickness {#2}%
%  \contourlength{#3}%
%  \noindent\rlap{\uline{\hspace{\textwidth}}}\contour{white}{#4}%
%  \endgroup%
%}

% === Renewing package macros ===

% === Packages to be loaded LAST ===

\RequirePackage[perpage,multiple,stable]{footmisc}

