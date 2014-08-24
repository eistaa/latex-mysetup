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
\ProvidesClass{eistaart}[2014/08/24 v1.0 My personal article class]


%%   /-----------\
%% --+-- setup --+-- %% -------------------------------------------------------
%%   \-----------/


\RequirePackage{kvoptions}              % key-value options

\SetupKeyvalOptions{%
    family=eistaart,%
    prefix=eistaart@%
}

%% ----- declare options

% load my standard setup
\DeclareStringOption{eistaasetup}[{%
        math,theorems,text,figures,%
        enumitem={inline}%
    }]
% load my code setup
\DeclareStringOption{eistaacode}[{%
        minted,xmargins=-2cm%
    }]
% load my drawing setup
\DeclareStringOption{eistaadrawing}[%
        tikz%
    ]

% whether to use normal fonts (default is to use special setup)
\DeclareBoolOption[false]{normalfonts}

% language
\DeclareStringOption[english]{language}

% xcolor options
\DeclareStringOption[{usenames,dvipsnames,svgnames,table}]{xcolor}

% fallback
\DeclareDefaultOption{%
    \@unknownoptionerror
}

%% ----- process given options

\ProcessKeyvalOptions*

%% ----- package & class options

%% setup

\PassOptionsToClass{11pt}{article}
\PassOptionsToPackage{a4paper,twoside,hmarginratio=1:1,margin=1.5in,headheight=15.0pt}%
                     {geometry}
\PassOptionsToPackage{\eistaart@language}{babel}

%% my classes

\PassOptionsToPackage{\eistaart@eistaasetup}{eistaasetup}

\PassOptionsToPackage{\eistaart@eistaacode}{eistaacode}
\PassOptionsToPackage{beramono=false}{eistaacode}  % do it in this class instead

\PassOptionsToPackage{\eistaart@eistaadrawing}{eistaadrawing}
\PassOptionsToPackage{xcolor={\eistaart@xcolor}}{eistaadrawing}


%%   /---------------------------\
%% --+-- base class & packages --+-- %% ---------------------------------------
%%   \---------------------------/


%% load base class
\LoadClass{article}

% fonts
\ifeistaart@normalfonts \else
    % use special fonts
    \RequirePackage[sc]{mathpazo}       % use adobe palatino familly of fonts with true small caps
    \linespread{1.05}                   % palatino needs more leading (space between lines)
    \RequirePackage[euler-hat-accent]
                   {eulervm}            % use ams euler font for math
    \RequirePackage[scaled]{beramono}   % use beramono as monospace font. supports bold and italic
\fi

% encoding & language
\RequirePackage[utf8]{inputenc}         % input encoding is utf-8
\RequirePackage[T1]{fontenc}            % encode fonts as T1
\RequirePackage{babel}                  % language

% used for styling
\RequirePackage{fancyhdr}               % to create custom header/footers
\RequirePackage{geometry}               % to mess with page geometry
\RequirePackage{titlesec}               % to style sections


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

% load enumitem if not loaded, since styling is dependant upon it
\@ifpackageloaded{enumitem}{ }{
    \RequirePackage{enumitem}           % to style lists
}


%%   /--------------\
%% --+-- commands --+-- %% ----------------------------------------------------
%%   \--------------/


%% title command (from amsart class, http://ctan.org/pkg/amsart)
%% - defines \@shorttitle and \@title commands
\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\edef\title{\noexpand\@dblarg%
    \expandafter\noexpand\csname\string\title\endcsname}
\let\@shorttitle\@empty \let\@title\@empty

%% author command (based on amsart class, http://ctan.org/pkg/amsart)
%% - allows multiple authors if called multiple times
\renewcommand*{\author}[1]{%
    \ifx\authors\@empty
        \gdef\authors{#1}%
    \else
        \g@addto@macro\authors{\\#1}%
    \fi}
\let\authors\@empty

%% wrapper around date
\renewcommand*{\date}[1]{\gdef\@date{#1}}
\let\@date\@empty


%%   /-------------\
%% --+-- styling --+-- %% -----------------------------------------------------
%%   \-------------/


%% ----- numbering

% number within section
\@ifpackagewith{eistaasetup}{math}{ \numberwithin{equation}{section} }{ }
\@ifpackagewith{eistaasetup}{figures}{ \numberwithin{figure}{section} }{ }
\numberwithin{table} {section}

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
\renewcommand{\headrulewidth}{2pt} % 2pt thick line after header
\renewcommand{\footrulewidth}{0pt} % no line before footer

%% header
\fancyhead[LE,RO]{\thepage}
\fancyhead[CE]   {\textsc{\@@author}}
\fancyhead[CO]   {\textsc{\@shorttitle}}
%% footer
% \fancyfoot[...]{...}

%% plain style
\fancypagestyle{plain}{%
    \fancyhf{} % clear
    % only date on first page
    \fancyfoot[L]{\ifthenelse{\value{page}=1}{\textit{Date:}\@date}{}}
    % pagenumber on every page
    \fancyfoot[C]{\thepage}
    % no header line but this footer line
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0.5pt}
}


%% ----- titlepage

\renewcommand{\maketitle}{
    \thispagestyle{plain}
    \begin{center}
        \rule{1\textwidth}{0.8pt} \\
        \Large\sc\@title          \\
        \rule{1\textwidth}{0.8pt} \\
        \vskip 1em
        \large\sc\authors
        \vskip 5em
    \end{center}
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
    {\thesubsection.}% label
    {1em}% separator between label & title body
    {\@periodafter}% title macro
% subsubsection
\titleformat{\subsubsection}[runin]% command & shape
    {\normalfont\normalsize\bf}% format
    {\thesubsubsection.}% label
    {1em}% separator between label & title body
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

\endinput
