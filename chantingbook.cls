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

\newif\ifwebversion
\webversionfalse

\newif\ifshowwirebinding
\showwirebindingfalse

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
  babelLanguage/.default=british,
  babelLanguage/.store in=\BOOK@babelLanguage,
  webversion/.default=\webversionfalse,
  webversion/.code={\webversiontrue},
  showwirebinding/.default=\showwirebindingfalse,
  showwirebinding/.code={\showwirebindingtrue},
}

\newcommand\theLanguage\BOOK@babelLanguage

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

\RequirePackage[\BOOK@babelLanguage]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage[cmyk]{xcolor}
\RequirePackage{xcoffins}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{booktabs}
\RequirePackage{footnote}
\RequirePackage{hyphenat}
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
\definecolor{section}{gray}{0.1}
\definecolor{instruction}{gray}{0.5}
\definecolor{footnoterule}{gray}{0.5}
\definecolor{link}{rgb}{0.2,0.2,1}% not so light blue

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./fonts/}, }

\setmainfont[
  ItalicFont=GentiumIncantation-Italic.ttf,
  BoldFont=GenBkBasB.ttf,
  BoldItalicFont=GenBkBasBI.ttf,
  StylisticSet=2,
]{GentiumIncantation-Regular.ttf}

\newfontfamily\SanghaIcons{SanghaIcons.ttf}

\newfontfamily\AlegreyaSans{AlegreyaSans-Regular.otf}
\newfontfamily\AlegreyaSansSC{AlegreyaSansSC-Regular.otf}
\newfontfamily\UbuntuLight{Ubuntu-L.ttf}
\newfontfamily\UbuntuMedium{Ubuntu-X-Medium.ttf}

\newfontfamily\headerFont{AlegreyaXSansSC-Bold.otf}

\newfontfamily\pageNumFont[
  LetterSpace=5.0,
  Numbers=Lining,
]{AlegreyaXSansSC-Bold.otf}

\newfontfamily\chapterTitleFont{Ubuntu-X-Medium.ttf}
\newfontfamily\sectionFont{Ubuntu-X-Medium.ttf}
\newfontfamily\subSectionFont{Ubuntu-X-Medium.ttf}

\newfontfamily\partNameFont{AlegreyaXSansSC-Bold.otf}
\newfontfamily\partTitleFont{Ubuntu-X-Medium.ttf}

\newfontfamily\TOCpartTitleFont{Ubuntu-X-Medium.ttf}
\newfontfamily\TOCchapterTitleFont{GentiumIncantation-Regular.ttf}

\newfontfamily\instructionFont{AlegreyaXSansSC-Bold.otf}

% font sizes

\newcommand{\headerSize}
  {\@setfontsize\headerSize{12}{12}}
\newcommand{\pageNumSize}
  {\@setfontsize\pageNumSize{18.5}{18.5}}

\newcommand{\chapterTitleSize}
  {\@setfontsize\chapterTitleSize{17}{20}}
\newcommand{\sectionSize}
  {\@setfontsize\sectionSize{13}{15}}
\newcommand{\subSectionSize}
  {\@setfontsize\subSectionSize{12}{14}}

\newcommand{\partNameSize}
  {\@setfontsize\partNameSize{17}{17}}
\newcommand{\partTitleSize}
  {\@setfontsize\partTitleSize{25}{25}}

\newcommand{\TOCpartTitleSize}
  {\@setfontsize\TOCpartTitleSize{17}{20}}
\newcommand{\TOCchapterTitleSize}
  {\@setfontsize\TOCchapterTitleSize{15}{20}}

% === microtype ===

\RequirePackage[final,babel=true]{microtype}
%\SetTracking[spacing={500,100,}]{encoding=*, family=chapterTitleFont}{40}

% === hyperref ===

\RequirePackage{hyperref}

\ifwebversion
% Web version: colored link text
\hypersetup{
  unicode=true,
  colorlinks=true,
  linkcolor=link,
  citecolor=link,
  filecolor=link,
  urlcolor=link
}
\else
% Print version: link colors to text color, so that it doesn't
% interfere with printing, but can still test is link targets work.
\hypersetup{
  colorlinks=true,
  unicode=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody
}
\fi

\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% === penalties and hyphenation ===

% memoir's more allowing penalties
\midsloppy

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
%\finalhyphendemerits=5000 % default is 5000
\brokenpenalty=990

\RequirePackage[defaultlines=2,all]{nowidow}

\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\theISBN{\@theISBN}

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

\def\BOOK@appendixFontSizePt{11}
\def\BOOK@appendixLineHeightPt{17}

\newcommand{\appendixsize}{%
  \@setfontsize\appendixsize\BOOK@appendixFontSizePt\BOOK@appendixLineHeightPt
  \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}

\newlength\englishTextParskip

\newcommand*\setEnglishTextSize[3]{%
  \def\BOOK@englishTextFontSizePt{#1}%
  \def\BOOK@englishTextLineHeightPt{#2}%
  \setlength{\englishTextParskip}{#3}%
}

\setEnglishTextSize{12}{18}{9pt}

\newcommand{\englishtextsize}{%
  \@setfontsize\englishtextsize\BOOK@englishTextFontSizePt\BOOK@englishTextLineHeightPt
  \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}

% === indentations ===

\newlength\leaderIndent
\setlength{\leaderIndent}{1.8em}

\setlength{\vgap}{1.5em}
\setlength{\vindent}{\leaderIndent}
\setlength{\vleftmargin}{2em}

\setlength{\parskip}{5pt}
\setlength{\parindent}{0pt}

% === tabular ===

\setlength{\tabcolsep}{1em}

\renewcommand{\arraystretch}{1.238}% 21+5 / 21, (lineheight + parskip) / lineheight

\newcommand\oldArr{}% holding old \arraystrech for restore
\let\oldArr\arraystrech

\newcommand\setArrayStrech[1]{%
  \let\oldArr\arraystretch
  \renewcommand{\arraystretch}{#1}%
}

\newcommand\restoreArrayStretch{\let\arraystretch\oldArr}

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
\setmarginnotes{14pt}{70pt}{5pt}

\marginparmargin{outer}
\sideparmargin{outer}

\checkandfixthelayout% This will typeout values in pt.
\settypeoutlayoutunit{mm}% It is useful to see layout values in mm too.
\typeoutlayout

% === marginpar, sidepar ===

\renewcommand\sideparfont{%
  \UbuntuMedium\small
}

\renewcommand*\sideparform{%
  \ifmemtortm\raggedright\else\raggedleft\fi
}


% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newlength\BOOK@bleed
\setlength{\BOOK@bleed}{3mm}

\NewCoffin\HeaderWrap
\NewCoffin\HeaderText
\NewCoffin\HeaderRule
\NewCoffin\HeaderPageNum
\NewCoffin\WireBinding

\newlength\BOOK@headWidth
\newlength\BOOK@headExtra
\newlength\BOOK@headRuleSep

\setlength{\BOOK@headExtra}{35pt}
\setlength{\BOOK@headWidth}{\textwidth + \BOOK@headExtra}
%\setlength{\BOOK@headRuleSep}{6pt}
\setlength{\BOOK@headRuleSep}{25pt}

\newlength\pageNumBoxHeight
\setlength{\pageNumBoxHeight}{28pt}

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
    \color{headrule}\rule{\paperwidth - \spinemargin + \BOOK@bleed}{0.5pt}%
  }%
}

\newcommand\setHeaderPageNum{%
  \SetHorizontalCoffin\HeaderPageNum{%
    \setlength{\fboxsep}{0pt}%
    \colorbox{headrule}{\parbox[t][\pageNumBoxHeight][c]{\foremargin - \BOOK@headExtra + \BOOK@bleed}{%
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

\newcommand\setWireBinding{%
  \SetHorizontalCoffin\WireBinding{%
    \includegraphics[width=20mm]{wirebinding.pdf}%
  }%
}

\makeoddhead{toprightnum}%
{%
  \assumeoddpagetrue
  \setHeaderText
  %\setHeaderRule
  \setHeaderPageNum
  \ifshowwirebinding
    \setWireBinding
  \fi
  \JoinCoffins\HeaderWrap\HeaderText
  %\JoinCoffins*\HeaderWrap[l,b]\HeaderRule[l,t](0pt,-\BOOK@headRuleSep)%
  \JoinCoffins*\HeaderWrap[r,b]\HeaderPageNum[l,t](0pt,-\BOOK@headRuleSep)%
  \ifshowwirebinding
    \JoinCoffins*\HeaderWrap[l,t]\WireBinding[l,t](-\spinemargin-12mm,\headheight)%
  \fi
  \TypesetCoffin\HeaderWrap
}{}{}%

\makeevenhead{toprightnum}%
{%
  \assumeoddpagefalse
  \setHeaderText
  %\setHeaderRule
  \setHeaderPageNum
  \ifshowwirebinding
    \setWireBinding
  \fi
  \JoinCoffins\HeaderWrap\HeaderText
  %\JoinCoffins*\HeaderWrap[l,b]\HeaderRule[l,t]({-\foremargin+\BOOK@headExtra-\BOOK@bleed},-\BOOK@headRuleSep)%
  \JoinCoffins*\HeaderWrap[l,b]\HeaderPageNum[r,t](0pt,-\BOOK@headRuleSep)%
  \ifshowwirebinding
    \JoinCoffins*\HeaderWrap[l,t]\WireBinding[l,t](\textwidth+\BOOK@headExtra+\spinemargin-8mm,\headheight)%
  \fi
  \TypesetCoffin\HeaderWrap
}{}{}%

\makeoddfoot{toprightnum}{}{}{}
\makeevenfoot{toprightnum}{}{}{}

\newcommand\psMarksDefault{%
  \def\chaptermark##1{%
    \markboth{##1}{\rightmark}}%
  \def\partmark##1{%
    \markright{##1}{}}%
  \let\sectionmark\@gobble
}

\makepsmarks{toprightnum}{\psMarksDefault}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{toprightnum}
\aliaspagestyle{chapter}{toprightnum}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

% === TOC settings ===

\maxtocdepth{chapter}

\renewcommand*{\thepart}{\@arabic\c@part}

% Fixes Undefined control sequence error for \@chapapp@head
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

\newif\ifTocDelegatePageNumber
\TocDelegatePageNumberfalse

\newcommand\chapterTocDelegatePageNumber{\addtocontents{toc}{%
  \protect \global \protect \TocDelegatePageNumbertrue
  \protect \global \protect \HasDelegatedPageNumbertrue
}}

\newcommand\setTocDelegatedPageNumber{\addtocontents{toc}{%
  \protect \setcounter{delegatedpage}{\thepage}
}}

\newcommand\nextChapterUseDelegatedPageNumber{\addtocontents{toc}{%
  \protect \global \protect \HasDelegatedPageNumbertrue
  \protect \global \protect \TocDelegatePageNumberfalse
}}

\newcommand\delegateSetUseNext{%
  \chapterTocDelegatePageNumber
  \setTocDelegatedPageNumber
  \nextChapterUseDelegatedPageNumber
}

\newif\ifTocSubIndent
\TocSubIndentfalse

\newif\ifHasDelegatedPageNumber
\HasDelegatedPageNumberfalse

\newcommand\chapterTocSubIndentTrue{\addtocontents{toc}{\protect  \TocSubIndenttrue}}
\newcommand\chapterTocSubIndentFalse{\addtocontents{toc}{\protect \TocSubIndentfalse}}

\newcounter{delegatedpage}
\setcounter{delegatedpage}{0}

% Format:
% \titlecontents{ section }[ left ]
% { above-code }
% { numbered-entry-format }
% { numberless-entry-format }
% { filler-page-format }
% [ below-code ]

% the right TOC margin
\contentsmargin{0pt}

\titlecontents{part}[0pt]%
{\addvspace{20pt}}%
{%
  \contentsmargin{0pt}%
  \TOCpartTitleFont\TOCpartTitleSize
  \partname~\thecontentslabel
  \hspace*{1em}%
  \filright%
}%
{}%
{%
  \hfill
  \TOCpartTitleFont\TOCpartTitleSize
  \thecontentspage
}%
[\addvspace{5pt}]

\newcommand\resumeNormalText{%
  \normalsize%
  \setlength{\parskip}{5pt}%
}

\newcommand\englishText{%
  \englishtextsize%
  \setlength{\parskip}{\englishTextParskip}%
}
\newcommand\paliText{\resumeNormalText}

\newlength\tocPageWidth

\newlength\tocThreeDigits
\setlength{\tocThreeDigits}{\widthof{\UbuntuMedium\normalsize 999}}

\titlecontents{chapter}[0pt]%
{%
  \ifTocSubIndent
    \addvspace{-2pt}%
  \else
    \addvspace{5pt}%
  \fi
  \ifHasDelegatedPageNumber
    \setlength{\tocPageWidth}{\widthof{\UbuntuMedium\normalsize \thedelegatedpage\ / \thecontentspage}}
  \else
    \setlength{\tocPageWidth}{\tocThreeDigits}
  \fi
  \addtolength{\tocPageWidth}{10pt}
  \contentsmargin{\tocPageWidth}%
  \filright%
}%
{%
  \TOCchapterTitleFont\TOCchapterTitleSize
  \ifTocSubIndent
    \hspace*{1em}%
  \fi
  \global\TocSubIndentfalse
}%
{}%
{%
  \ifTocDelegatePageNumber\relax
  \else
    \hspace*{10pt}%
    \small\color{black!60}%
    \titlerule*[8pt]{.}%
    \hspace*{10pt}%
    \color{textbody}
    \UbuntuMedium\small
    \parbox{\tocPageWidth}{%
      \raggedleft\UbuntuMedium\normalsize
      \ifHasDelegatedPageNumber
        \thedelegatedpage\ / \thecontentspage%
        \global\HasDelegatedPageNumberfalse
      \else
        \thecontentspage
      \fi
    }%
    \hspace*{-\tocPageWidth}%
  \fi
  \global\TocDelegatePageNumberfalse
}%
[\addvspace{5pt}]

% === List of First Lines ===

\newcommand\listfirstlinesname{List of First Lines}
\newlistof{listfirstlines}{fir}{\listfirstlinesname}

% Fixed number for \chapternumberline, not acutally using it but
% required for syntax
\newcommand{\firstline}[1]{\addcontentsline{fir}{firstline}{\protect\chapternumberline{1} #1}}

\contentsuse{firstline}{fir}

\titlecontents{firstline}[0pt]%
{%
  \addvspace{5pt}%
  \setlength{\tocPageWidth}{\tocThreeDigits}
  \addtolength{\tocPageWidth}{10pt}
  \contentsmargin{\tocPageWidth}%
  \filright%
}%
{%
  \TOCchapterTitleFont\TOCchapterTitleSize
}%
{}%
{%
  \hspace*{10pt}%
  \small\color{black!60}%
  \titlerule*[8pt]{.}%
  \hspace*{10pt}%
  \parbox{\tocPageWidth}{%
    \raggedleft\UbuntuMedium\normalsize
    \thecontentspage}%
  \hspace*{-\tocPageWidth}%
}%
%[\addvspace{2pt}]

% === Book styles ===

% === Part styles ===

\renewcommand{\partnamefont}{\partNameFont\partNameSize}
\renewcommand{\partnumfont}{\partNameFont\partNameSize}
\renewcommand{\parttitlefont}{\partTitleFont\partTitleSize}

\renewcommand{\printpartname}{}
\renewcommand{\partnamenum}{}
\renewcommand{\printpartnum}{}

\NewCoffin\PartWrap
\NewCoffin\PartBackground
\NewCoffin\PartName
\NewCoffin\PartTitle

\newlength\partBgWidth
\setlength{\partBgWidth}{70pt}

\newlength\partTitleSep
\setlength{\partTitleSep}{40pt}

\newlength\headerTextHeight
\setlength{\headerTextHeight}{\heightof{%
    \parbox{\BOOK@headWidth}{\headerFmt hello}%
}}

\renewcommand{\printparttitle}[1]{%
  \SetHorizontalCoffin\PartWrap{}%
  \SetHorizontalCoffin\PartBackground{%
    \color{headrule}\rule{\partBgWidth + \BOOK@bleed}{\paperheight+2\BOOK@bleed}%
  }%
  \SetHorizontalCoffin\PartName{%
    \setlength{\fboxsep}{0pt}%
    \colorbox{white}{\parbox[t][\pageNumBoxHeight][c]{\partBgWidth + 4pt + \BOOK@bleed}{
      \hspace*{2pt}%
      \raggedright
      \color{header}%
      \MakeLowercase{\partnamefont \partname \hspace*{0.3em} \partnumfont \arabic{part}}%
    }}%
  }%
  \SetHorizontalCoffin\PartTitle{%
    \parbox[t]{\paperwidth - \partBgWidth - \partTitleSep - \BOOK@bleed}{
      \raggedleft
      \color{chaptertitle}%
      \parttitlefont #1%
    }%
  }%
  \JoinCoffins*\PartWrap[r,t]\PartBackground[r,t]( -\spinemargin+\paperwidth+\BOOK@bleed, \trimtop -\topmargin +4pt +\BOOK@bleed )%
  \JoinCoffins*\PartWrap[\PartBackground-l,\PartBackground-t]\PartName[l,t]( -2pt, -\headerTextHeight -\BOOK@headRuleSep -\pageNumBoxHeight )%
  \JoinCoffins*\PartWrap[\PartBackground-l,\PartBackground-t]\PartTitle[r,t]( -\partTitleSep, -0.5\textheight )%
  \TypesetCoffin\PartWrap
}

% Chapters are \openany, but part pages should open on recto pages
\renewcommand{\@setuppart}{%
  \cleartorecto
  \thispagestyle{part}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
}

% Leave the part page style to \printparttitle, thanks.
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
  {\printparttitle{#2}}%
  \@endpart}

% === Chapter styles ===

\setsecnumdepth{chapter}

\raggedbottom

% define chapter styles with "fantasy" names

\NewCoffin\ChapterTitle
\NewCoffin\TitleRule

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
    \SetHorizontalCoffin\ChapterTitle{%
      \parbox{\linewidth}{%
        \raggedright\chaptitlefont\color{chaptertitle} ##1%
      }%
    }%
    \SetHorizontalCoffin\TitleRule{%
      \color{headrule}\rule{\linewidth}{0.5pt}%
    }
    \JoinCoffins*\ChapterTitle[l,b]\TitleRule[l,t](0pt,-3pt)%
    \TypesetCoffin\ChapterTitle
  }
}

\makechapterstyle{tocchapter}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{40pt}
  \setlength{\afterchapskip}{30pt}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\printchapternum{}
  \renewcommand\afterchapternum{}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\partTitleFont\partTitleSize}
  \renewcommand*\printchaptertitle[1]{%
    \begin{minipage}{\linewidth}%
      \raggedright
      \chaptitlefont\color{chaptertitle}%
      ##1%
    \end{minipage}%
  }
}

\makechapterstyle{tocchapternoskip}{
  \chapterstyle{tocchapter}
  \setlength{\beforechapskip}{0pt}
  \renewcommand*{\chapterheadstart}{\vspace{\beforechapskip}}
}

% Commands to assign the chapter styles to book parts. Use \renewcommand
% to adjust.

\newcommand\frontmatterChapterStyle{\chapterstyle{tocchapter}}
\newcommand\mainmatterChapterStyle{\chapterstyle{innerpenstroke}}
%\newcommand\appendixChapterStyle{\chapterstyle{hightitle}}
%\newcommand\backmatterChapterStyle{\chapterstyle{hightitle}}

%% append them to the macros

\addtodef{\frontmatter}{}{%
  \aliaspagestyle{chapter}{empty}
  \pagestyle{empty}
  \frontmatterChapterStyle
  \openany
}

\addtodef{\mainmatter}{}{
  \aliaspagestyle{chapter}{toprightnum}
  \pagestyle{normalpage}
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

\setsecheadstyle{\sectionFont\sectionSize\color{section}}

\setsubsecheadstyle{\subSectionFont\subSectionSize\color{section}}

% === Custom commands and environments ===

% Cantillation marks

\newcommand*\cUL[1]{#1\symbol{"A712}}
\newcommand*\cU[1]{#1\symbol{"A713}}
\newcommand*\cD[1]{#1\symbol{"A715}}
\newcommand*\cDL[1]{#1\symbol{"A716}}

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

\newlength\englishIndent
\setlength{\englishIndent}{\leaderIndent}

\newenvironment{english}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    \englishIndent%
    \rightmargin   0em%
    \parsep        \z@ \@plus\p@%
  }%
  \item[] \raggedright\itshape}%
  {\endlist}

\newcommand\tr[1]{\textit{#1}}

\newcommand\trline[1]{%
  \begin{english}%
    #1%
  \end{english}%
}

\newcommand{\instr}[1]{%
  \hfill
  {\instructionFont\color{instruction}\upshape%
  [\space\MakeLowercase{#1}\space]}%
}

\newcommand{\soloinstr}[1]{%
  {\centering
  {\instructionFont\normalsize\color{instruction}\upshape%
  [\space\MakeLowercase{#1}\space]}%
  \par}%
}

\newenvironment{instruction}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    \leaderIndent
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

\newenvironment{onechants}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    0em%
    \rightmargin   0em%
    \parsep        0pt%
  }%
  \item[] \renewcommand{\arraystretch}{1.238}% 21+5 / 21, (lineheight + parskip) / lineheight
  \begin{tabular}{@{}l@{}}}%
  {\end{tabular}\endlist}

\newenvironment{threechants}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    0em%
    \rightmargin   0em%
    \parsep        0pt%
  }%
  \item[] \renewcommand{\arraystretch}{1.238}% 21+5 / 21, (lineheight + parskip) / lineheight
  \begin{tabular}{@{}l l l@{}}}%
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

\newenvironment{soloonechants}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    0em%
    \rightmargin   0em%
    \parsep        0pt%
  }%
  \item[] \renewcommand{\arraystretch}{1}%
  \begin{tabular}{@{}l@{}}}%
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

\newenvironment{packeditemize}%
{\begin{itemize}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=4pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{itemize}}

\newlength\preceptnumwidth
\setlength{\preceptnumwidth}{\widthof{\normalsize 9.\space}}

\newenvironment{precept}%
{\begin{enumerate}[
  itemindent=0pt,
  leftmargin={\preceptnumwidth},
  rightmargin=0pt,
]%
}{\end{enumerate}}

\newenvironment{paritta}%
  {\list{}{%
    \topsep 0pt
    \listparindent 0em%
    \itemindent    0em%
    \leftmargin    1.8em% \leaderIndent, but keep it a separate value
    \rightmargin   0em%
    \parsep        7pt%
  }%
  \item[] \raggedright}%
  {\endlist}

\newcommand\suttaref[1]{%
  {\raggedleft #1\par}%
}

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

\long\def\framenorule#1{%
  \leavevmode
  \hbox{%
    \hskip-\@wholewidth
    \vbox{%
      \vskip-\@wholewidth
      \hbox{#1}%
      \vskip-\@wholewidth}%
    \hskip-\@wholewidth}}


% If class option webversion is used, show content in a paper sized
% minipage, empty page otherwise.
% Redefine \color{webcoverbg} to change page background color.
\newcommand\webcover[1]{%
\thispagestyle{empty}\mbox{}
\ifwebversion
\AddToShipoutPictureFG*{\put(0,0){%
\begin{minipage}[b][\paperheight][c]{\paperwidth}%
#1
\end{minipage}}}
\fi
\clearpage
}

% === Renewing package macros ===

\renewcommand\footnoterule{%
  \vspace*{\baselineskip}%
  \kern-3\p@
  {\color{footnoterule}\hrule height 0.25pt width \columnwidth}
  \kern2.6\p@}

% Don't use the optional argument for TOC, only for \chaptermark
\def\@chapter[#1]#2{%
  \m@mpn@new@chaptrue%
  \m@mpn@new@schapfalse%
  \def\f@rbdy{#2}%
  \def\f@rtoc{#2}%
  \ifx\ch@pt@c\@empty % no optional args
    \def\f@rhdr{#2}%
  \else                  % at least one opt arg
    \ifx\@empty#1\@empty
      \let\f@rhdr\ch@pt@c
    \else
      \def\f@rhdr{#1}%
    \fi
  \fi
  \m@m@Andfalse
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \m@m@Andtrue
    \fi
  \fi
  \ifm@m@And
    \refstepcounter{chapter}%
  \fi
  \ifartopt
    \@makechapterhead{#2}%
    \@afterheading
    \chaptermark{\f@rhdr}%
  \else
    \chaptermark{\f@rhdr}
    \insertchapterspace
    \if@twocolumn
      \@topnewpage[\@makechapterhead{#2}]%
    \else
      \@makechapterhead{#2}%
    \fi
    \@afterheading
  \fi
  \@nameuse{chapter@f@rtoc@before@write@hook}%
  \mempreaddchaptertotochook%
  \ifm@m@And
    \ifanappendix
      \addcontentsline{toc}{appendix}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \memappchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \addcontentsline{toc}{chapter}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \memchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{\f@rtoc}%
    \ifanappendix
      \memappchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \memchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \fi
  \mempostaddchaptertotochook%
  \ifheadnameref\M@gettitle{\f@rhdr}\else\M@gettitle{\f@rtoc}\fi%
  \memendofchapterhook%
}

% === Packages to be loaded LAST ===

\RequirePackage[perpage,multiple,stable]{footmisc}

% End of chantingbook.cls
