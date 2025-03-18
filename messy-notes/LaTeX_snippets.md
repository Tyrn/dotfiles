## Miscellaneous snippets
#### 5x8 character matrix paper
```
\documentclass[
  10pt
  ,a4paper
  ,oneside
]{article}

\usepackage{wasysym}

\setlength{\parindent}{0pt}
\usepackage[margin=0.5in]{geometry}
\pagenumbering{gobble}

\usepackage{expl3}
\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\renewcommand{\baselinestretch}{0.5}

\newcommand{\rfive}{
  \Repeat{5}{\Circle}
}

\newcommand{\lineoffive}{
  \Repeat{12}{\rfive\hspace{8pt}}
  \rfive
}

\newcommand{\lineoffivebyeight}{
  \Repeat{7}{\lineoffive\newline}
  \lineoffive
}

\newcommand{\pageoffivebyeight}{
  \Repeat{13}{\lineoffivebyeight\newline\newline}
  \lineoffivebyeight
}

\begin{document}

% One page of 5x8 character matrices

{\tiny \pageoffivebyeight}

\end{document}
```

#### Shortcuts

Alt=M, Meta=Win=s
```
1. Leading Dash (ru) Meta+Alt+j ---~[-:-:-:Shift+`]
2. Long Dash (ru) Meta+Alt+k ~---~[Shift+`:-:-:-:Shift+`]
3. Left Quote (ru) Meta+Alt+, <<[Shift+,:Shift+,]
4. Right Quote (ru) Meta+Alt+. >>[Shift+.:Shift+.]
5. Ellipsis (ru) Meta+Alt+/ \ldots\ [\:l:d:o:t:s:\]
6. Ellipted Question (ru) Meta+Alt+; ?..[Shift+/:.:.]
7. Ellipted Exclamation (ru) Meta+Alt+l !..[Shift+1:.:.]
8. Combined Ellipsis (ru) Meta+/ \ldots~---~[\:l:d:o:t:s:Shift+`:-:-:-:Shift+`]
```
#### Font management
```
$ updmap-sys --listmaps
```

#### Tabular horizontal alignment

[Discussion and suggestions](https://tex.stackexchange.com/questions/365682/justifying-ragged-right-left-center-all-the-tables-in-a-document)

#### Table decimal number/label on:
```
\documentclass[11pt,a4paper,oneside]{memoir}

\pagestyle{plain}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
%\usepackage{fontspec}
%\usepackage{changepage}

%\setmainfont[Mapping=tex-text]{Liberation Serif}
%\setsansfont[Mapping=tex-text]{Liberation Sans}
%\setmonofont[Mapping=tex-text]{Liberation Mono}

\usepackage{pgfkeys}
\makeatletter
\newif\if@placedleft
\newif\if@placedright
\newif\if@placedmiddle
\newif\if@placedcapused
\newif\if@placedscapused
\newif\if@placedlabused
\newdimen\@placedpadding
\pgfkeys{/placedt/.is family,/placedt,
    default/.style={% change the default settings here
        place=left,
        stretch=1.4,
        padding=1cm,
    },
    stretch/.estore in=\arraystretch,
    place/.is choice,
        place/left/.code=\@placedlefttrue\@placedrightfalse\@placedmiddlefalse,
        place/right/.code=\@placedrighttrue\@placedleftfalse\@placedmiddlefalse,
        place/middle/.code=\@placedmiddletrue\@placedleftfalse\@placedrightfalse,
    padding/.estore in=\@placedpadding,
    caption/.code=\@placedcapusedtrue\def\@placedcap{#1},
    scaption/.code=\@placedscapusedtrue\def\@placedscap{#1},
    label/.code=\@placedlabusedtrue\def\@placedlab{#1},
}

\newenvironment{placedtabular}[2][]{%
    \par\medskip\noindent\begin{minipage}{\textwidth}%
        \pgfkeys{/placedt, default, #1}%
        \if@placedleft%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \hskip\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedright%
        \else\if@placedmiddle%
            \centering%
        \else\if@placedright%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedleft%
        \fi\fi\fi%
        \if@placedcapused%
            \refstepcounter{table}%
            \tablename~\thetable: \@placedcap%
            \if@placedscapused%
                \addcontentsline{lot}{table}{\@placedscap}%
            \else%
                \addcontentsline{lot}{table}{\@placedcap}%
            \fi%
            \if@placedlabused%
                \label{\@placedlab}%
            \fi%
            \\[0.2\baselineskip]%
        \fi%
        \footnotesize\begin{tabular}{#2}%
    }{
        \end{tabular}%
        \if@placedmiddle\else%
            \end{minipage}%
        \fi%
    \end{minipage}%
    }
\makeatother

\newcommand{\leftpadding}{1cm}

\begin{document}
\listoftables

    \chapter{}

    All Gaul is divided into three parts, one of which the Belgae inhabit, the Aquitani another, those who in their own language are called Celts, in our Gauls, the third. All these differ from each other in language, customs and laws. The river Garonne separates the Gauls from the Aquitani; the Marne and the Seine separate them from the Belgae. 

    \begin{placedtabular}[caption=Caption,label=tab:first]{|c|c|}
            \hline
            {Alfa}
            & {Bravo}
            \\\hline

            {Charlie}
            & {Delta}
            \\\hline
    \end{placedtabular}

    \medskip\begin{adjustwidth}{\leftpadding}{0cm}
        \raggedright{Caption}\\
        \renewcommand*{\arraystretch}{1.4}
        \footnotesize\begin{tabular}[c]{|c|c|}

            \hline
            {Alfa}
            & {Bravo}
            \\\hline

            {Charlie}
            & {Delta}
            \\\hline

        \end{tabular}
    \end{adjustwidth}

    \bigskip
    Of all these, the Belgae are the bravest, because they are furthest from the civilization and refinement of [our] Province, and merchants least frequently resort to them, and import those things which tend to effeminate the mind.

    \begin{placedtabular}[caption=Another Caption,label=tab:second]{|c|c|}
            \hline
            {Longer Echo}
            & {Long Foxtrot}
            \\\hline

            {Golf}
            & {Hotel}
            \\\hline
    \end{placedtabular}
    \medskip\begin{adjustwidth}{\leftpadding}{0cm}
        \raggedright{Another Caption}\\
        \renewcommand*{\arraystretch}{1.4}
        \footnotesize\begin{tabular}[c]{|c|c|}

            \hline
            {Longer Echo}
            & {Long Foxtrot}
            \\\hline

            {Golf}
            & {Hotel}
            \\\hline

        \end{tabular}
    \end{adjustwidth}

    \bigskip
    They are the nearest to the Germans, who dwell beyond the Rhine, with whom they are continually waging war; for which reason the Helvetii also surpass the rest of the Gauls in valor.

\end{document}
```

#### Table decimal number/label off:
```
\makeatletter
\newif\if@placedleft
\newif\if@placedright
\newif\if@placedmiddle
\newif\if@placedcapused
\newif\if@placedscapused
%\newif\if@placedlabused
\newdimen\@placedpadding
\pgfkeys{/placedt/.is family,/placedt,
    default/.style={%
        place=left,
        stretch=1.4,
        padding=1cm,
    },
    stretch/.estore in=\arraystretch,
    place/.is choice,
        place/left/.code=\@placedlefttrue\@placedrightfalse\@placedmiddlefalse,
        place/right/.code=\@placedrighttrue\@placedleftfalse\@placedmiddlefalse,
        place/middle/.code=\@placedmiddletrue\@placedleftfalse\@placedrightfalse,
    padding/.estore in=\@placedpadding,
    caption/.code=\@placedcapusedtrue\def\@placedcap{#1},
    scaption/.code=\@placedscapusedtrue\def\@placedscap{#1},
}

\newenvironment{placedtabular}[2][]{%
    \par\medskip\noindent\begin{minipage}{\textwidth}%
        \pgfkeys{/placedt, default, #1}%
        \if@placedleft%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \hskip\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedright%
        \else\if@placedmiddle%
            \centering%
        \else\if@placedright%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedleft%
        \fi\fi\fi%
        \if@placedcapused%
            \refstepcounter{table}%
            \@placedcap%
            \if@placedscapused%
                \addcontentsline{lot}{table}{\@placedscap}%
            \else%
                \addcontentsline{lot}{table}{\@placedcap}%
            \fi%
            \\[0.2\baselineskip]%
        \fi%
        \footnotesize\begin{tabular}{#2}%
    }{
        \end{tabular}%
        \if@placedmiddle\else%
            \end{minipage}%
        \fi%
    \end{minipage}%
    }
\makeatother
```
#### Skillmon's notes:

Usage of the placedtabular-environment is just like a normal tabular except, that in the optional argument you can use a comma seperated key=value syntax. The following keys are alailable:

stretch: the value used for arraystretch in all tables set with the placedtabular
place: the placement of the table. Available are left, right and middle
padding: the space to the left or right margin with place=left or place=right, respectively
caption: the caption used for the table
scaption: the table-name for the \listoftables, if not used caption is used. If caption is not used, this doesn't have any effect.
label: the label used for referencing the table
When you use one of these keys in a placedtabular-environment, the effects are only local and don't affect any other table set with this environment.

From the aforementioned keys place, stretch and padding have a default value, which are set in between the brackets of default/.style={...} which is used inside the first call of \pgfkeys in the above MWE. There is also the comment 'change the default settings here'.

EDIT2: The below code is everything inbetween of \makeatletter and \makeatother and doesn't set 'table x.y' infront of the caption. Because of this, I also removed the label-key as referencing won't work with this.


#### Tabular horizontal alignment, update by Skillmon:
```
\documentclass[11pt,a4paper,oneside]{memoir}

\pagestyle{plain}

\usepackage{fontspec}
%\usepackage{changepage}

\setmainfont[Mapping=tex-text]{Liberation Serif}
\setsansfont[Mapping=tex-text]{Liberation Sans}
\setmonofont[Mapping=tex-text]{Liberation Mono}

\usepackage{pgfkeys}
\makeatletter
\newif\if@placedleft
\newif\if@placedright
\newif\if@placedmiddle
\newif\if@placedcapused
\newif\if@placedscapused
\newif\if@placedfontused
\newif\if@placedcfontused
\newdimen\@placedpadding
\pgfkeys{/placedt/.is family,/placedt,
    default/.style={%
        place=left,
        stretch=1.4,
        padding=1cm,
    },
    stretch/.estore in=\arraystretch,
    place/.is choice,
        place/left/.code=\@placedlefttrue\@placedrightfalse\@placedmiddlefalse,
        place/right/.code=\@placedrighttrue\@placedleftfalse\@placedmiddlefalse,
        place/middle/.code=\@placedmiddletrue\@placedleftfalse\@placedrightfalse,
    padding/.estore in=\@placedpadding,
    caption/.code=\@placedcapusedtrue\def\@placedcap{#1},
    scaption/.code=\@placedscapusedtrue\def\@placedscap{#1},
    font/.store in=\@placedfont,
    captionfont/.store in=\@placedcapfont,
    font/.code=\@placedfontusedtrue\def\@placedfont{#1},
    captionfont/.code=\@placedcfontusedtrue\def\@placedcapfont{#1},
}

\newenvironment{placedtabular}[2][]{%
    \par\medskip\noindent\begin{minipage}{\textwidth}%
        \pgfkeys{/placedt, default, #1}%
        \if@placedleft%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \hskip\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedright%
        \else\if@placedmiddle%
            \centering%
        \else\if@placedright%
            \newdimen\@placedrest%
            \@placedrest=\textwidth%
            \advance\@placedrest by -\@placedpadding%
            \begin{minipage}{\@placedrest}%
                \raggedleft%
        \fi\fi\fi%
        \if@placedcapused%
            {\if@placedcfontused\normalsize\normalfont\@placedcapfont\fi\@placedcap}%
            \if@placedscapused%
                \addcontentsline{lot}{table}{\@placedscap}%
            \else%
                \addcontentsline{lot}{table}{\@placedcap}%
            \fi%
            \\[0.2\baselineskip]%
        \fi%
        \if@placedfontused\normalsize\normalfont\@placedfont\fi%
        \begin{tabular}{#2}%
    }{
        \end{tabular}%
        \if@placedmiddle\else%
            \end{minipage}%
        \fi%
    \end{minipage}%
    }
\makeatother

\newcommand{\leftpadding}{1cm}

\begin{document}
\listoftables

    \chapter{}

    All Gaul is divided into three parts, one of which the Belgae inhabit, the Aquitani another, those who in their own language are called Celts, in our Gauls, the third. All these differ from each other in language, customs and laws. The river Garonne separates the Gauls from the Aquitani; the Marne and the Seine separate them from the Belgae. 

    \begin{placedtabular}[caption=Caption,font=\bfseries]{|c|c|}
            \hline
            {Alfa}
            & {Bravo}
            \\\hline

            {Charlie}
            & {Delta}
            \\\hline
    \end{placedtabular}

    \medskip\begin{adjustwidth}{\leftpadding}{0cm}
        \raggedright{Caption}\\
        \renewcommand*{\arraystretch}{1.4}
        \footnotesize\begin{tabular}[c]{|c|c|}

            \hline
            {Alfa}
            & {Bravo}
            \\\hline

            {Charlie}
            & {Delta}
            \\\hline

        \end{tabular}
    \end{adjustwidth}

    \bigskip
    Of all these, the Belgae are the bravest, because they are furthest from the civilization and refinement of [our] Province, and merchants least frequently resort to them, and import those things which tend to effeminate the mind.

    \begin{placedtabular}[caption={Another\protect\\Caption}]{|c|c|}
            \hline
            {Longer Echo}
            & {Long Foxtrot}
            \\\hline

            {Golf}
            & {Hotel}
            \\\hline
    \end{placedtabular}
    \begin{placedtabular}[caption=Another Caption]{|c|c|}
            \hline
            {Longer Echo}
            & {Long Foxtrot}
            \\\hline

            {Golf}
            & {Hotel}
            \\\hline
    \end{placedtabular}
    \medskip\begin{adjustwidth}{\leftpadding}{0cm}
        \raggedright{Another Caption}\\
        \renewcommand*{\arraystretch}{1.4}
        \footnotesize\begin{tabular}[c]{|c|c|}

            \hline
            {Longer Echo}
            & {Long Foxtrot}
            \\\hline

            {Golf}
            & {Hotel}
            \\\hline

        \end{tabular}
    \end{adjustwidth}

    \bigskip
    They are the nearest to the Germans, who dwell beyond the Rhine, with whom they are continually waging war; for which reason the Helvetii also surpass the rest of the Gauls in valor.

\end{document}
```
