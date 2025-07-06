\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dazhuan}[Mao Zedong Dazhuan]
\ProcessOptions\relax

\RequirePackage{fix-cm}
\LoadClass[zihao=5,twoside,openany,fontset=none]{ctexbook}
%\RequirePackage{zhlineskip}

% PDF 页面导入
\RequirePackage{pdfpages}

% 页面设置，大32开本，140x203，103x163，28x27
\RequirePackage{geometry}
\geometry
  {
    paperheight=203mm,
    paperwidth=140mm,
    top=24mm,
    bottom=19mm,
    left=18.5mm, % 21mm
    right=18.5mm, % 16mm
    footskip=10mm
  }

% 字体设置
\setmainfont{XITS}
% 正文：思源宋体 Light 粗体：思源宋体 Medium
\setCJKmainfont{Source Han Serif SC Light}
  [
    BoldFont=Source Han Serif SC,
    ItalicFont=FZKai-Z03,
    FallBack={SimSun, SimSun-ExtB}
  ]
\setCJKsansfont{Source Han Sans SC Light}[BoldFont=Source Han Sans SC]
\setCJKmonofont{FZFangSong-Z02}

\setCJKfamilyfont{zhsong}{Source Han Serif SC Light}
\setCJKfamilyfont{zhxbs}{Source Han Serif SC SemiBold}
\setCJKfamilyfont{zhdbs}{Source Han Serif SC Bold}
\setCJKfamilyfont{zhhei}{Source Han Sans SC Light}
\setCJKfamilyfont{zhdh}{Source Han Sans SC Bold}
\setCJKfamilyfont{zhfs}{FZFangSong-Z02}
\setCJKfamilyfont{zhkai}{FZKai-Z03}

\newcommand{\songti}{\CJKfamily{zhsong}}
\newcommand{\xbsong}{\CJKfamily{zhxbs}}
\newcommand{\dbsong}{\CJKfamily{zhdbs}}
\newcommand{\heiti}{\CJKfamily{zhhei}}
\newcommand{\dahei}{\CJKfamily{zhdh}}
\newcommand{\fangsong}{\CJKfamily{zhfs}}
\newcommand{\kaishu}{\CJKfamily{zhkai}}

\RenewDocumentCommand{\tableofcontents}{O{toc}}{
  \clearpage
  \mbox{}\par
  {\centering\dbsong\zihao{3}
  目\qquad 录\normalfont\normalsize\par}
  \vspace{\baselineskip}\par  
  \@starttoc{#1}
  \clearpage
}

% 目录格式
%\renewcommand{\contentsname}{目\qquad 录}
\RequirePackage{titletoc}
\titlecontents{part}[0pt]{\xbsong}{}{}{\hfill\contentspage}
\titlecontents{chapter}[1em]{\normalfont}{}{}{\hfill\contentspage}

% 卷标题文本
\let\Oldpart\part
\newcommand{\parttitle}{}
\RenewDocumentCommand{\part}{O{} m}{
    \Oldpart[#1]{#2}
    \renewcommand{\parttitle}{#1}
}

% 标题格式
\ctexset{
	part={
		%numbering=false,
        name={第,卷},
		format=\centering\zihao{1}\dbsong,
		pagestyle=plain
	},
	chapter={
		numbering=false,
		format=\centering\zihao{3}\dbsong,
		beforeskip=\baselineskip,
		afterskip=\baselineskip,
		pagestyle=plain
	},
}

% 页眉、页脚样式
\RequirePackage[headings]{fancyhdr}
\fancypagestyle{plain}{ % 其他页面
	\fancyhf{}
	\fancyfoot[C]{\zihao{-5}\thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{headings}{ % 正文页面
	\fancyhf{}
	\fancyhead[RO,LE]{\zihao{-5}\kaishu\leftmark}
    \fancyhead[LO]{\zihao{-5}\kaishu\parttitle}
    \fancyhead[RE]{\zihao{-5}\kaishu 第\chinese{part}卷}
	\fancyfoot[C]{\zihao{-5}\thepage} %RO,LE
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}

% 侧边栏
\RequirePackage{hyperref}
\hypersetup{hidelinks,
	colorlinks=true,
	allcolors=black,
	pdfstartview=Fit,
	breaklinks=true
}

% 图片
\RequirePackage{graphicx}
% 页面脚注
\RequirePackage[perpage]{footmisc}

% 参考书目列表
\RequirePackage{enumitem}
\setlist{
	topsep=0pt,
	itemsep=0pt,
	parsep=0pt,
	partopsep=0pt,
	itemindent=0em,
	listparindent=0pt,
	leftmargin=1em
}

% 文本引语
\RenewDocumentEnvironment{quote}{O{1em}O{1em}O{\baselineskip}}
{%
    \begin{list}{}
        {
            \setlength{\topsep}{0pt}
            \setlength{\parskip}{0pt}
            \setlength{\parsep}{0pt}
            \setlength{\partopsep}{#3}
            \setlength{\leftmargin}{#1}
            \setlength{\rightmargin}{#2}
            \setlength{\itemindent}{\parindent}
            \setlength{\listparindent}{\parindent}
        } \item[]
    }
    {\normalfont \end{list}}

% 章标题下引语
\NewDocumentEnvironment{pref}{}
  {\begin{quote}[6em][0pt]\kaishu}{\end{quote}}
  
% 正文引语
\NewDocumentEnvironment{xquote}{}
{\begin{quote}[1em][1em][0pt]\fangsong}{\end{quote}}

% 多段落引语，不能跨段
\NewDocumentEnvironment{xemph}{}{\kaishu}{\normalfont}

% 诗歌环境
% 默认居中对齐  \begin{poem}{标题}[日期]...\end{poem}
% 带星号两端对齐 \begin{poem}*[左边界]{标题}[日期]...\end{poem}
\NewDocumentEnvironment{poem}{s O{6.25em} m o }
  {
    \mbox{}\par
    \begingroup\centering\zihao{-4}\dbsong
      #3\normalfont\normalsize\par\endgroup
    \IfNoValueF{#4}{\begingroup\centering #4\par\endgroup}
    \vspace{0.5\baselineskip}
    \IfBooleanTF{#1}
      {\begingroup\setlength{\parindent}{#2}}
      {\begingroup\centering}
  }
  {
  	\IfBooleanTF{#1}
  	  {\endgroup}{\par\endgroup}
  }

% 诗歌环境中的小序
\newlength{\templen}
\NewDocumentEnvironment{xpref}{}
  { 
  	\setlength{\templen}{\parindent}
  	\setlength{\parindent}{0pt}  	
  	\begin{minipage}{\textwidth}\setlength{\parindent}{2em}
  }
  {
    \end{minipage}\vspace{\baselineskip - 1em}\par
    \setlength{\parindent}{\templen}	
  }

% 诗歌环境中的分标题
\NewDocumentCommand{\subtitle}{m}
{\par\begingroup\centering\kaishu #1\par\normalfont\endgroup}
