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

\LoadClass[11pt,twoside,article]{memoir}

% === Book Core ===

\RequirePackage[british]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage[cmyk]{xcolor}
\RequirePackage{xcoffins}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
%\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{booktabs}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{tikz}
\usetikzlibrary{positioning}

% === Define colors ===

\definecolor{textbody}{gray}{0.15}
\definecolor{header}{gray}{0.1}
\definecolor{headrule}{gray}{0.5}
\colorlet{pagenum}{white}
\definecolor{chaptertitle}{gray}{0.1}
\definecolor{instruction}{gray}{0.5}

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./fonts/}, }

\setmainfont[
  ItalicFont=GentiumIncantation-Italic.ttf,
  BoldFont=GenBkBasB.ttf,
  BoldItalicFont=GenBkBasBI.ttf,
  StylisticSet=2,
]{GentiumIncantation-Regular.ttf}

\newfontfamily\AlegreyaSans{AlegreyaSans-Regular.otf}
\newfontfamily\AlegreyaSansSC{AlegreyaSansSC-Regular.otf}
\newfontfamily\UbuntuMedium{Ubuntu-M.ttf}

\newfontfamily\headerFont{AlegreyaSansSC-Bold.otf}

\newfontfamily\pageNumFont[
  LetterSpace=5.0,
  Numbers=Lining,
]{AlegreyaSansSC-Bold.otf}

\newfontfamily\chapterTitleFont{Ubuntu-M.ttf}

\newfontfamily\partNameFont{AlegreyaSansSC-Bold.otf}
\newfontfamily\partTitleFont{Ubuntu-M.ttf}

\newfontfamily\instructionFont{AlegreyaSansSC-Bold.otf}

% font sizes

\newcommand{\headerSize}
  {\@setfontsize\headerSize{12}{12}}
\newcommand{\pageNumSize}
  {\@setfontsize\pageNumSize{18.5}{18.5}}

\newcommand{\chapterTitleSize}
  {\@setfontsize\chapterTitleSize{17}{20}}

\newcommand{\partNameSize}
  {\@setfontsize\partNameSize{17}{17}}
\newcommand{\partTitleSize}
  {\@setfontsize\partTitleSize{25}{25}}

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

% === tabular ===

\setlength{\tabcolsep}{1em}
\renewcommand{\arraystretch}{1.238}% 21+5 / 21, (lineheight + parskip) / lineheight

% === setup page layout ===

\newlength\BOOK@paperHeight
\newlength\BOOK@paperWidth
%\setstocksize{250mm}{185mm}% 1.35, Nicholas
\setlength{\BOOK@paperHeight}{250mm}% ~1.376, Short Pentagon
\setlength{\BOOK@paperWidth}{181mm}

\ifshowtrims
  \stockaiv% use A4 paper size to show trims
  \setlength{\paperheight}{\BOOK@paperHeight}
  \setlength{\paperwidth}{\BOOK@paperWidth}
  \trimXmarks
  \trimLmarks
  \quarkmarks
  \settrims{0.5\stockheight - 0.5\paperheight}{0.5\stockwidth - 0.5\paperwidth}
  \settrimmedsize{\BOOK@paperHeight}{\BOOK@paperWidth}{*}
\else\relax
  \setstocksize{\BOOK@paperHeight}{\BOOK@paperWidth}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
\fi

%\newlength\BOOK@longestLine
%\setlength{\BOOK@longestLine}{\widthof{%
%    \normalsize
%    I am indeed the Dhamma's servant, the Dhamma is my Lord and Guide.%
%}}
%\typeout{Longest line: \the\BOOK@longestLine}
%% Longest line: 361.54785pt

\settypeblocksize{586pt}{362pt}{1.618}% 1.618, Golden section
\setlrmargins{*}{*}{1.618}
\setulmargins{20mm}{*}{*}
\setheaderspaces{*}{12mm}{*}
%\setlength{\footskip}{3\baselineskip}

\checkandfixthelayout% This will typeout values in pt.
\settypeoutlayoutunit{mm}% It is useful to see layout values in mm too.
\typeoutlayout

% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newlength\BOOK@bleed
\setlength{\BOOK@bleed}{3mm}

\NewCoffin\HeaderWrap
\NewCoffin\HeaderText
\NewCoffin\HeaderRule
\NewCoffin\HeaderPageNum

\newlength\BOOK@headWidth
\newlength\BOOK@headExtra
\newlength\BOOK@headRuleSep

\setlength{\BOOK@headExtra}{35pt}
\setlength{\BOOK@headWidth}{\textwidth + \BOOK@headExtra}
\setlength{\BOOK@headRuleSep}{6pt}

\makepagestyle{toprightnum}

\makerunningwidth{toprightnum}{\BOOK@headWidth}
\makeheadposition{toprightnum}{flushright}{flushleft}{center}{center}

\newcommand\headerFmt{\headerFont\headerSize\color{header}}
\newcommand\pageNumFmt{\pageNumFont\pageNumSize\color{pagenum}}

\newif\ifassumeoddpage

\newcommand\setHeaderText{%
  \SetHorizontalCoffin\HeaderText{%
    \parbox{\BOOK@headWidth}{%
      \headerFmt%
      \ifassumeoddpage
        \MakeLowercase{\rightmark}%
        \hfill%
        \MakeLowercase{\leftmark}%
      \else
        \MakeLowercase{\leftmark}%
        \hfill%
        \MakeLowercase{\rightmark}%
      \fi
    }%
  }%
}

\newcommand\setHeaderRule{%
  \SetHorizontalCoffin\HeaderRule{%
    \color{headrule}\rule{\paperwidth + 2\BOOK@bleed}{0.5pt}%
  }%
}

\newcommand\setHeaderPageNum{%
  \SetHorizontalCoffin\HeaderPageNum{%
    \setlength{\fboxsep}{0pt}%
    \colorbox{headrule}{\parbox[t][28pt][c]{\foremargin - \BOOK@headExtra + \BOOK@bleed}{%
      \pageNumFmt
      \ifassumeoddpage
        \raggedright
        \hspace*{15pt}%
        \thepage%
      \else
        \raggedleft
        \thepage%
        \hspace*{15pt}%
      \fi
    }}%
  }%
}

\makeoddhead{toprightnum}%
{%
  \assumeoddpagetrue
  \setHeaderText
  \setHeaderRule
  \setHeaderPageNum
  \JoinCoffins\HeaderWrap\HeaderText
  \JoinCoffins*\HeaderWrap[l,b]\HeaderRule[l,t]({-\spinemargin-\BOOK@bleed},-\BOOK@headRuleSep)%
  \JoinCoffins*\HeaderWrap[r,b]\HeaderPageNum[l,t](0pt,-\BOOK@headRuleSep)%
  \TypesetCoffin\HeaderWrap
}{}{}%

\makeevenhead{toprightnum}%
{%
  \assumeoddpagefalse
  \setHeaderText
  \setHeaderRule
  \setHeaderPageNum
  \JoinCoffins\HeaderWrap\HeaderText
  \JoinCoffins*\HeaderWrap[l,b]\HeaderRule[l,t]({-\foremargin+\BOOK@headExtra-\BOOK@bleed},-\BOOK@headRuleSep)%
  \JoinCoffins*\HeaderWrap[l,b]\HeaderPageNum[r,t](0pt,-\BOOK@headRuleSep)%
  \TypesetCoffin\HeaderWrap
}{}{}%

\makeoddfoot{toprightnum}{}{}{}
\makeevenfoot{toprightnum}{}{}{}

\makepsmarks{toprightnum}{%
  \def\chaptermark##1{%
    \markboth{##1}{\rightmark}}%
  \def\partmark##1{%
    \markright{##1}{}}%
  \let\sectionmark\@gobble
}

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

\renewcommand{\partnamefont}{\partNameFont\partNameSize}
\renewcommand{\partnumfont}{\partNameFont\partNameSize}
\renewcommand{\parttitlefont}{\partTitleFont\partTitleSize}

\renewcommand{\printpartname}{}
\renewcommand{\partnamenum}{}
\renewcommand{\printpartnum}{}

\renewcommand{\printparttitle}[1]{%
  \hspace*{0.4\linewidth}%
  \begin{minipage}{0.6\linewidth}%
    \raggedright
    \MakeLowercase{\partnamefont \partname \hspace*{0.3em} \partnumfont \arabic{part}}%
    \midpartskip
    {\parttitlefont #1}%
  \end{minipage}%
}

% Don't center the part page, thanks.
\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \def\f@rtoc{#1}%
  \@nameuse{part@f@rtoc@before@write@hook}%
  \phantomsection
  \mempreaddparttotochook
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}%
      {\protect\partnumberline{\thepart}\f@rtoc}%
    \mempartinfo{\thepart}{\f@rtoc}{#2}%
  \else
    \addcontentsline{toc}{part}{\f@rtoc}%
    \mempartinfo{}{\f@rtoc}{#2}%
  \fi
  \mempostaddparttotochook
  \partmark{#1}%
  {%\centering
   \interlinepenalty \@M
   \parskip\z@
   \normalfont
   \ifnum \c@secnumdepth >-2\relax
     \printpartname \partnamenum \printpartnum
     \midpartskip
   \fi
   \printparttitle{#2}\par}%
  \@endpart}

% === Chapter styles ===

\setsecnumdepth{chapter}

% define chapter styles with "fantasy" names

\makechapterstyle{innerpenstroke}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{3.5ex \@plus 1ex \@minus .2ex}
  \renewcommand*{\chapterheadstart}{\vspace{\beforechapskip}}
  \setlength{\afterchapskip}{2.3ex \@plus .2ex}
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

%% append them to the macros

%\addtodef{\frontmatter}{}{\frontmatterChapterStyle}

\addtodef{\mainmatter}{}{
  \setcounter{chapter}{0}
  \mainmatterChapterStyle
  \raggedright
  \openany
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

\newlength\leaderIndent
\setlength{\leaderIndent}{\widthof{\normalsize\hspace*{1.8em}}}

\newenvironment{leader}%
  {\list{}{%
  \topsep 0pt%
  \listparindent 0em%
  \itemindent    0pt%
  \leftmargin    \leaderIndent
  \rightmargin   \leaderIndent
  \parsep        \z@ \@plus\p@}
  \item[] \raggedright}%
  {\endlist}

\newcommand\tr[1]{\textit{#1}}

\newenvironment{english}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    \leaderIndent%
    \rightmargin   0em%
    \parsep        \z@ \@plus\p@%
  }%
  \item[] \raggedright\itshape}%
  {\endlist}

\newcommand{\instr}[1]{%
  \hfill
  {\instructionFont\color{instruction}\upshape%
  [\space\MakeLowercase{#1}\space]}%
}

\newcommand{\instrLeft}[1]{%
  {\instructionFont\color{instruction}\upshape%
  [\space\MakeLowercase{#1}\space]}%
}

\newcommand{\soloinstr}[1]{%
  {\centering
  {\instructionFont\color{instruction}\upshape%
  [\space\MakeLowercase{#1}\space]}%
  \par}%
}

\newenvironment{instruction}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    2\leaderIndent
    \rightmargin   0em%
    \parsep        \z@ \@plus\p@%
  }%
  \item[] \begingroup
    \raggedright\instructionFont\color{instruction}\upshape
    [\space
  }%
  {\space]\endgroup\endlist}

\newenvironment{twochants}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    0em%
    \rightmargin   0em%
    \parsep        0pt%
  }%
  \item[] \renewcommand{\arraystretch}{1.238}% 21+5 / 21, (lineheight + parskip) / lineheight
  \begin{tabular}{@{}l l@{}}}%
  {\end{tabular}\endlist}

\newenvironment{solotwochants}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    0em%
    \rightmargin   0em%
    \parsep        0pt%
  }%
  \item[] \renewcommand{\arraystretch}{1}%
  \begin{tabular}{@{}l l@{}}}%
  {\end{tabular}\endlist}

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

% === Renewing package macros ===

% === Packages to be loaded LAST ===

\RequirePackage[perpage,multiple,stable]{footmisc}

