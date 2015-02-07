%% eistaart.cls
%% Copyright 2014 -- Eivind Storm Aarnæs
%%
%% This work may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3 of this license or (at your
%% option) any later version. The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Eivind Storm Aarnæs.
%%
%% This work consists of the files eistaart.cls, eistaasetup.sty,
%% eistaacode.sty, eistaadrawing.sty and mathletters.sty.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eistaart}[2014/10/01 v1.2 My personal article class]

%% --+-- setup --+-- %% {{{* --------------------------------------------------
%%   \-----------/


%% ----- load key-val stuff

\RequirePackage{kvoptions-patch}        % patch key-val options (allow lists)
\RequirePackage{xkeyval}                % key-value options

%% ----- declare options

% load my standard setup
\define@cmdkey{eistaart.cls}[eistaart@]{eistaasetup}[{%
        math,theorems,text,figures,%
        enumitem={inline}%
    }]{}
% load my code setup
\define@cmdkey{eistaart.cls}[eistaart@]{eistaacode}[{%
        minted,xmargins=-1cm%
    }]{}
% load my drawing setup
\define@cmdkey{eistaart.cls}[eistaart@]{eistaadrawing}[{%
        tikz%
    }]{}

% whether to use normal fonts (default is to use special setup)
\define@boolkey{eistaart.cls}[eistaart@]{normalfonts}[true]{}

% language
\define@cmdkey{eistaart.cls}[eistaart@]{language}{}

% xcolor options
\define@cmdkey{eistaart.cls}[eistaart@]{xcolor}{}

% whether to load packages to control references
\define@boolkey{eistaart.cls}[eistaart@]{referencing}[true]{}

% add coffee stains on front page
\define@boolkey{eistaart.cls}[eistaart@]{coffee}[true]{}    % load coffee4
\define@boolkey{eistaart.cls}[eistaart@]{nostains}[true]{}  % no default stains

% fallback
\DeclareOptionX*{%
    \ClassWarning{eistaart}{Unknown option '\CurrentOption'}
}

%% ----- set defaults

\setkeys{eistaart.cls}{%
    eistaasetup={},%
    eistaacode={},%
    eistaadrawing={},%
    normalfonts=false,%
    language=english,%
    xcolor={dvipsnames,svgnames,x11names},%
    referencing=false,%
    coffee={false},%
    nostains={false},%
}

%% ----- process given options

\ProcessOptionsX

%% ----- package & class options

%% setup

\PassOptionsToClass{11pt,\eistaart@language}{article}
\PassOptionsToPackage{a4paper,twoside,hmarginratio=1:1,margin=1.5in,headheight=15.0pt}%
                     {geometry}
\PassOptionsToPackage{\eistaart@language}{babel}

\PassOptionsToPackage{\eistaart@xcolor}{xcolor}

%% my classes

\PassOptionsToPackage{\eistaart@eistaasetup}{eistaasetup}

\PassOptionsToPackage{\eistaart@eistaacode}{eistaacode}
\PassOptionsToPackage{beramono=false}{eistaacode}  % do it in this class instead

\PassOptionsToPackage{\eistaart@eistaadrawing}{eistaadrawing}
\PassOptionsToPackage{xcolor={\eistaart@xcolor}}{eistaadrawing}
%% *}}}

%% --+-- base class & packages --+-- %% {{{* ----------------------------------
%%   \---------------------------/


%% load base class
\LoadClass{article}

% fixes to LaTeX2e
\RequirePackage{fixltx2e}

% fonts
\ifeistaart@normalfonts \else
    % use special fonts
    \RequirePackage[sc]{mathpazo}       % use adobe palatino familly of fonts with true small caps
    \linespread{1.05}                   % palatino needs more leading (space between lines)
    \RequirePackage[euler-hat-accent]%
                   {eulervm}            % use ams euler font for math
    \RequirePackage[scaled]{beramono}   % use beramono as monospace font. supports bold and italic
\fi

% encoding & language
\RequirePackage[utf8]{inputenc}         % input encoding is utf-8
\RequirePackage[T1]{fontenc}            % encode fonts as T1
\RequirePackage{babel}                  % language

% colors
\ifx\eistaart@xolor\@empty \else
    \RequirePackage{xcolor}
\fi

% used for styling
\RequirePackage{fancyhdr}               % to create custom header/footers
\RequirePackage{geometry}               % to mess with page geometry
\RequirePackage{titlesec}               % to style sections
\RequirePackage{chngcntr}               % control counters
\ifeistaart@coffee
    \RequirePackage{coffee4}
\fi

% my standard setup
\ifx\eistaart@eistaasetup\@empty \else
    \RequirePackage{eistaasetup}
\fi
% my code setup
\ifx\eistaart@eistaacode\@empty \else
    \RequirePackage{eistaacode}
\fi
% my drawing setup
\ifx\eistaart@eistaadrawing\@empty \else
    \RequirePackage{eistaadrawing}
\fi

% improve spacing between words and letters
\RequirePackage{microtype}

% load enumitem if not loaded, since styling is dependant upon it
\@ifpackageloaded{enumitem}{ }{
    \RequirePackage{enumitem}           % to style lists
}

% load referencing packages
\ifeistaart@referencing
    \RequirePackage[capitalize]{cleveref}
    \RequirePackage{autonum}
\fi
%% *}}}

%% --+-- titlepage --+-- %% {{{* ----------------------------------------------
%%   \---------------/


%% title command (from amsart class, http://ctan.org/pkg/amsart)
%% - defines \@shorttitle and \@title commands
\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\edef\title{\noexpand\@dblarg%
    \expandafter\noexpand\csname\string\title\endcsname}
\let\@shorttitle\@empty \let\@title\@empty

%% author command (based on amsart class, http://ctan.org/pkg/amsart)
%% - allows multiple authors if called multiple times
%% - defines \@shortauthors and \@authors commands
\renewcommand*{\author}[2][]{%
    \ifx\@empty\@authors
        \gdef\@author{#2}%
        \gdef\@authors{#2}%
    \else
        \g@addto@macro\@authors{\and#2}%
    \fi
    \ifx{#1}{\@empty} \else
        \ifx\@shortauthors\@empty
            \gdef\@shortauthors{#1}%
        \else
            \g@addto@macro\@shortauthors{, #1}%
        \fi
    \fi%
}
\edef\author{\noexpand\@dblarg%
    \expandafter\noexpand\csname\string\author\endcsname}
\let\@authors\@empty \let\@shortauthors\@empty


%% wrapper around date
\renewcommand*{\date}[1]{\gdef\@date{#1} \let\@@date\@date}
\let\@date\today \let\@@date\@date

%% ----- titlepage

\renewcommand*{\@maketitle}{
    \newpage \null \vskip 2em%
    \begin{minipage}{0.9\textwidth}\begin{center}
        \rule{1\textwidth}{0.8pt} \par \vskip 1em%
        \baselineskip 2.5em%
        {\LARGE\sc\@title}        \par \vskip 1em%
        \baselineskip 1em%
        \rule{1\textwidth}{1.2pt} \par \vskip 1em%
        {\large\sc
            \lineskip .5em%
            \begin{tabular}[t]{c}%
                \@authors
            \end{tabular} \par}
    \end{center}\end{minipage}
    \vskip 1em%
    \ifeistaart@coffee
        \ifeistaart@nostains \else
            \cofeAm{0.1}{1.0}{0}{4.5cm}{10.2cm}
            \cofeCm{0.4}{0.7}{155}{0.0cm}{12.0cm}
        \fi
    \fi
}
%% *}}}

%% --+-- styling --+-- %% {{{* ------------------------------------------------
%%   \-------------/


%% ----- labels & numbering

% number within section
\@ifpackagewith{eistaasetup}{math}{    \counterwithin{equation}{section} }{ }
\@ifpackagewith{eistaasetup}{figures}{ \counterwithin{figure}{section}   }{ }
\counterwithin{table}{section}

% equation label
\@ifpackagewith{eistaasetup}{math}{
    \let\old@tagform@\tagform@
    \def\tagform@#1{\hspace{0.1pt}\rlap{\hspace{0.5em}\old@tagform@{#1}}}
    \renewcommand{\eqref}[1]{\textup{\old@tagform@{\ref{#1}}}}
}{ }

%% ----- list style

% make item use less space
\setlist[description]{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\setlist[enumerate]  {noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\setlist[itemize]    {noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
% add : after description label and make it boldface
\renewcommand{\descriptionlabel}[1]{\hspace{\labelsep}\textbf{#1:}}

%% ----- header and footer

%% setup
\pagestyle{fancy}
\fancyhf{} % clear header & footer
\renewcommand{\headrulewidth}{0.5pt} % 2pt thick line after header
\renewcommand{\footrulewidth}{0pt} % no line before footer

%% header
\fancyhead[LE,RO]{\thepage}
\fancyhead[CE]   {\textsc{\@shortauthors}}
\fancyhead[CO]   {\textsc{\@shorttitle}}
%% footer
% \fancyfoot[...]{...}

%% plain style
\fancypagestyle{plain}{%
    \fancyhf{} % clear
    % only date on first page
    \fancyfoot[L]{\ifthenelse{\value{page}=1}{\textit{Date:} \@@date}{}}
    % pagenumber on every page
    \fancyfoot[C]{\thepage}
    % no header line but this footer line
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0.5pt}
}


%% ----- sections

% used to add a period after runin sections
\newcommand{\@periodafter}[1]{#1.}

% section
\titleformat{\section}[hang]% command & shape
    {\normalfont\large\filcenter\sc}% format
    {\thesection.}% label
    {1em}% separator between label & title body
    {}% title macro
% subsection
\titleformat{\subsection}[runin]% command & shape
    {\normalfont\normalsize\bf}% format
    {\llap{\thesubsection.\hspace{0.5em}}}% label
    {0.5em}% separator between label & title body
    {\@periodafter}% title macro
% subsubsection
\titleformat{\subsubsection}[runin]% command & shape
    {\normalfont\normalsize\bf}% format
    {\llap{\thesubsubsection.\hspace{0.5em}}}% label
    {0.5em}% separator between label & title body
    {\@periodafter}% title macro
% paragraph
\titleformat{\paragraph}[runin]% command & shape
    {\normalfont\normalsize\it}% format
    {\theparagraph}% label
    {1em}% separator between label & title body
    {\@periodafter}% title macro
% subparagraph
\titleformat{\subparagraph}[runin]% command & shape
    {\normalfont\normalsize\it}% format
    {\thesubparagraph}% label
    {1em}% separator between label & title body
    {\@periodafter}% title macro
%% *}}}

\endinput

