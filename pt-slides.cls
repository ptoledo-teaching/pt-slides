\ProvidesClass{pt-slides}[2021/07/01 v1.0 PT Slides Class]
\NeedsTeXFormat{LaTeX2e}

% Class handling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pass user options to pt-commons
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{pt-commons}
}
\ProcessOptions\relax
% Fixed options
\PassOptionsToClass{aspectratio=169}{beamer}
\PassOptionsToClass{12pt}{beamer}
\LoadClass{beamer}
% Loading pt-commons
\RequirePackage{pt-commons}

% Design %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sizes
\setbeamersize{
    text margin left    = .04\paperwidth,
    text margin right   = .029\paperwidth,
    sidebar width left  = 0mm,
    sidebar width right = 32mm,
    description width   = 10mm,
    mini frame size     = 10mm,
    mini frame offset   = 10mm
}
% Fonts
\setbeamerfont{title}{
    size=\Large,
    series=\bfseries
}
\setbeamerfont{titlesub}{
    size=\large,
    series=\normalfont
}
\setbeamerfont{details}{
    size=\scriptsize,
    series=\normalfont
}
\setbeamerfont{authors}{
    size=\footnotesize,
    series=\normalfont
}
\setbeamerfont{frametitle}{
    size=\large
}
\setbeamerfont{description item}{
    shape=\bfseries
}
\setbeamerfont{footnote}{
    size=\scriptsize,
    series=\normalfont
}
\setlength{\abovecaptionskip}{0.25cm}
\setlength{\belowcaptionskip}{0.25cm}
% Colors
\setbeamercolor{structure}{fg=ptdarkblue}
\setbeamercolor{normal text}{fg=ptdarkblue}
\setbeamercolor{footline}{bg=ptgray}
% Watermark
\usebackgroundtemplate % Required for watermark

% Elements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove logo
\setbeamertemplate{logo}{}
% Frame title
\setbeamertemplate{frametitle}{
    \vskip1em\par
    \usebeamerfont{frametitle}\insertframetitle\par
    \usebeamerfont{frametitlesub}\insertframesubtitle\par
}
% Frame footline
\setbeamertemplate{footline}{
    \leavevmode
    \hbox{%
        \usebeamerfont{footline}%
        \begin{beamercolorbox}[
                wd=\textwidth,
                ht=3ex,
                dp=1.6ex
            ]{footline}
            \hspace{0.5cm}
            \ifdefined\pt@classcode%
                \pt@classcode\ -
            \fi%
            \ifdefined\pt@classsemester%
                \pt@classsemester\ -
            \fi%
            \ifdefined\pt@title%
                \pt@title
            \fi%
            \hfill
            \ifdefined\pt@authors%
                \titleauthorsfooter{\ -\ }%
                \ -\ %
            \fi%
            \ifdefined\pt@version%
            v\pt@version\ -\ %
            \fi%
            [\parbox[t]{0.3cm}{\centering\insertframenumber}/\parbox[t]{0.3cm}{\centering\getrefnumber{lastframe}}]
            \hspace{0.5cm}
        \end{beamercolorbox}%
    }
    \vskip0pt
}
% Justified footnotes
\setbeamertemplate{footnote}{
    \noindent
    \justifying
    \insertfootnotemark
    \insertfootnotetext\par
}
% Background image for content pages
\newcommand\pt@backgroundcontent{
    \ifdefined\pt@background%
        \begin{tikzpicture}[remember picture, overlay]
            \clip (current page.south east)
            -- (current page.north east)
            -- ++(-30mm, 0mm)
            -- ++(0mm, -\paperheight)
            -- cycle;
            % Include background image
            \node[anchor=south east, inner sep=0, outer sep=0] at (current page.south east) {
                \includegraphics[height=\paperheight]{\pt@background}
            };
        \end{tikzpicture}
    \fi
}
% Background image for cover pages
\newcommand\pt@backgroundcover{
    \ifdefined\pt@background%
        \begin{tikzpicture}[remember picture, overlay]
            \clip (current page.south east)
            -- (current page.north east)
            -- ++(-5.1, 0)
            -- ++(-3, -\paperheight)
            -- cycle;
            % Include background image
            \node[anchor=south east, inner sep=0, outer sep=0] at (current page.south east) {
                \includegraphics[height=\paperheight]{\pt@background}
            };
            % Add a slight shadow
            \fill[
                black,
                path fading=title page picture fading,
                fading angle=-15
            ]
            (current page.south east)
            rectangle
            ++(-10, \dimexpr\paperheight+1cm);
        \end{tikzpicture}
    \fi
    \ifdefined\pt@logo%
        \begin{textblock*}{3.25cm}(13cm, 0cm)%
            \begin{minipage}[t][8.325cm][b]{\dimexpr\textwidth-2\fboxsep}%
                \centering%
                \setlength{\fboxsep}{0pt}%
                \adjustbox{max width=2.0cm, max height=1.75cm, keepaspectratio}{\includegraphics{\pt@logo}}%
            \end{minipage}%
        \end{textblock*}%
    \fi
}
% Background template
\setbeamertemplate{background}{
    \ifnum\insertframenumber=1 %
        \pt@backgroundcover%
    \else
        \ifnum\insertframenumber=\getrefnumber{lastframe}%
            \pt@backgroundcover%
        \else%
            \pt@backgroundcontent
        \fi%
    \fi%
}
% Title page
\setbeamertemplate{title page}{%
    \begin{textblock*}{10cm}(0.5cm,1.0cm)%
        \setlength{\fboxsep}{0pt}%
        \begin{minipage}[t][2cm][t]{\dimexpr\textwidth-2\fboxsep}%
            \raggedright%
            \usebeamerfont{title}%
            \ifdefined\pt@title%
                \pt@title\par%
            \fi%
            \usebeamerfont{titlesub}%
            \ifdefined\pt@titlesub%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@titlesubsub%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@spacing%
                \ifdefined\pt@title%
                    \vspace{0.5em}%
                \fi%
                \undef\pt@spacing
            \fi%
            \ifdefined\pt@titlesub%
                \pt@titlesub\par%
                \ifdefined\pt@titlesubsub%
                    \pt@titlesubsub\par%
                \fi%
            \fi%
        \end{minipage}%
    \end{textblock*}%
    \begin{textblock*}{10cm}(0.5cm,3.75cm)%
        \setlength{\fboxsep}{0pt}%
        \begin{minipage}[t][4cm][b]{\dimexpr\textwidth-2\fboxsep}%
            \raggedright%
            \usebeamertemplate{separator}\par%
            \usebeamerfont{details}%
            \ifdefined\pt@classname%
                \vspace{0.15cm}%
                \pt@classname\par%
            \fi
            \ifdefined\pt@classsemester%
                \ifdefined\pt@classcode%
                    \pt@classcode \ - \pt@classsemester\par%
                \else%
                    \pt@classsemester\par%
                \fi%
            \else%
                \ifdefined\pt@classcode%
                    \pt@classcode\par%
                \fi%
            \fi%
            \usebeamerfont{authors}%
            \ifdefined\pt@authors%
                \vspace{0.15cm}%
                \titleauthorsnames{\newline}\par%
            \fi%
            \usebeamerfont{details}%
            \ifdefined\pt@workgroup%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@department%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@school%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@university%
                \def\pt@spacing{true}%
            \fi%
            \ifdefined\pt@spacing%
                \vspace{0.15cm}%
                \undef\pt@spacing
            \fi%
            \ifdefined\pt@workgroup%
                \pt@workgroup\par%
            \fi%
            \ifdefined\pt@department%
                \pt@department\par%
            \fi%
            \ifdefined\pt@school%
                \pt@school\par%
            \fi%
            \ifdefined\pt@university%
                \pt@university\par%
            \fi%
            \ifdefined\pt@date%
                \edef\temp@date{\pt@date}%
                \ifx\temp@date\@empty%
                \else%
                    \vspace{0.15cm}%
                    \pt@date%
                    \def\pt@dateprinted{true}%
                \fi%
            \else%
                \vspace{0.15cm}%
                \insertdate%
                \def\pt@dateprinted{true}%
            \fi%
            \ifdefined\pt@version%
                \ifdefined\pt@dateprinted%
                    \ -\ %
                \else%
                    \vspace{0.15cm}%
                \fi%
                \undef\pt@dateprinted%
                v\pt@version%
            \fi%
        \end{minipage}%
    \end{textblock*}
}
% End page template
\setbeamertemplate{endpage}{
    \begin{minipage}{.7\textwidth}
        \vspace{1cm}
        \centering
        \usebeamerfont{title}
        \pt@labelquestions
    \end{minipage}
    \begin{textblock*}{8.3cm}(0.54cm, 7.25cm)\tiny
        \pt@labelbackgroundsource :\par                                      
        \pt@backgroundcredit\par
        \pt@labeltemplatecredit :\par
        \url{https://github.com/ptoledo-teaching/pt-slides}
    \end{textblock*}
}
% Show TOC
\newif\ifpt@showtoc
\pt@showtoctrue % Default: show TOC
\newcommand\ptshowtoc{\pt@showtoctrue}
\newcommand\pthidetoc{\pt@showtocfalse}
\ptshowtoc
% Show section TOC
\newcommand\ptshowtocsection{
    \begin{frame}
        \frametitle{Contenido}
        \tableofcontents[currentsection, hideothersubsections]
    \end{frame}
}
\newif\ifpt@showsection
\pt@showsectiontrue % Default: show section TOC
\newcommand\ptshowsection{\pt@showsectiontrue}
\newcommand\pthidesection{\pt@showsectionfalse}
\ptshowsection
% Show subsection TOC
\newcommand\ptshowtocsubsection{
    \begin{frame}
        \frametitle{\pt@labeltoc}
        \tableofcontents[currentsection, subsectionstyle=show/shaded/hide]
    \end{frame}
}
\newif\ifpt@showsubsection
\pt@showsubsectionfalse % Default: hide subsection TOC
\newcommand\ptshowsubsection{\pt@showsubsectiontrue}
\newcommand\pthidesubsection{\pt@showsubsectionfalse}
\pthidesubsection
% Show last frame
\newif\ifpt@showlastframe
\pt@showlastframetrue % Default: show last frame
\newcommand\ptshowlastframe{\pt@showlastframetrue}
\newcommand\pthidelastframe{\pt@showlastframefalse}
\ptshowlastframe

% Hooks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Beamer customizations
\AtBeginDocument{
    \setlength{\leftmargini}{0.5cm}
    \setlength{\leftmarginii}{1.1em}
    \setlength{\leftmarginiii}{1.1em}
    \setlength{\leftmarginiv}{1.1em}
    \setbeamertemplate{caption}[numbered]
    \setbeamertemplate{sections/subsections in toc}[square]
    \setbeamertemplate{itemize item}[circle]
    \setbeamertemplate{itemize subitem}[circle]
    \setbeamertemplate{itemize subsubitem}[circle]
    \setbeamertemplate{itemize subsubsubitem}[circle]
    \setbeamertemplate{frametitle continuation}{}
    \setbeamertemplate{navigation symbols}{}
    \setbeamertemplate{headline}{}
    \setbeamertemplate{separator}{%
        \usebeamercolor{separator}%
        \textcolor{fg}{\rule{.625\textwidth}{.5pt}}%
    }
}
% Title page
\AtBeginDocument{%
    \begin{frame}%
        \maketitle%
    \end{frame}%
    \ifpt@showtoc%
        \begin{frame}%
            \frametitle{\pt@labeltoc}%
            \tableofcontents[hideallsubsections]%
        \end{frame}%
    \fi
}
% TOC per section
\AtBeginSection[]{%
    \ifpt@showsection%
        \ptshowtocsection%
    \fi%
}
% TOC per subsection
\AtBeginSubsection[]{%
    \ifpt@showsubsection%
        \ptshowtocsubsection%
    \fi%
}
% Final slide
\AtEndDocument{%
    \ifpt@showlastframe%
        \begin{frame}%
            \usebeamertemplate{endpage}%
            \label{lastframe}%
        \end{frame}%
    \fi
}
