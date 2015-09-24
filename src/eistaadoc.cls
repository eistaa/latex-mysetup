%% eistaadoc.cls
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
%% This work consists of the files eistaadoc.cls, eistaasetup.sty,
%% eistaacode.sty, eistaadrawing.sty and mathletters.sty.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eistaadoc}[2015/09/11 v2.0.0-dev eistaa's document class]

%% --+-- setup --+-- %% {{{* --------------------------------------------------
%%   \-----------/

%% ----- load key-val stuff

\RequirePackage{kvoptions-patch}        % patch key-val options (allow lists)
\RequirePackage{xkeyval}                % key-value options

%% ----- declare options

%% my packages

% load my standard setup
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{eistaasetup}[{%
        math,theorems,text,figures,%
        enumitem={inline}%
    }]{}
% load my code setup
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{eistaacode}[{%
        minted,xmargins=-1cm%
    }]{}
% load my drawing setup
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{eistaadrawing}[{%
        tikz%
    }]{}

%% styling

% whether to format as a book, if false: approximate an article using book class
\define@boolkey{eistaadoc.cls}[eistaadoc@]{bookstyle}[true]{}
% whether to use normal fonts (default is to use special setup)
\define@boolkey{eistaadoc.cls}[eistaadoc@]{normalfonts}[true]{}
% language
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{language}{}
% whether to load packages to control references
\define@boolkey{eistaadoc.cls}[eistaadoc@]{referencing}[true]{}

%% functionality

% whether to hide all todo-notes
\define@boolkey{eistaadoc.cls}[eistaadoc@]{notodo}[true]{}

%% coffee?

% add coffee stains on front page
\define@boolkey{eistaadoc.cls}[eistaadoc@]{coffee}[true]{}    % load coffee4
\define@boolkey{eistaadoc.cls}[eistaadoc@]{nostains}[true]{}  % no default stains

%% package options

% nomencl options
\define@boolkey{eistaadoc.cls}[eistaadoc@]{nonomencl}[true]{}  % no default stains
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{nomencl}{}
% xcolor options
\define@boolkey{eistaadoc.cls}[eistaadoc@]{noxcolor}[true]{}  % no default stains
\define@cmdkey{eistaadoc.cls}[eistaadoc@]{xcolor}{}

% fallback
\DeclareOptionX*{%
    \ClassWarning{eistaadoc}{Unknown option '\CurrentOption'}
}

%% ----- set defaults

\setkeys{eistaadoc.cls}{%
    eistaasetup={},%
    eistaacode={},%
    eistaadrawing={},%
    bookstyle={false},%
    normalfonts={false},%
    language={english},%
    referencing={false},%
    notodo={false},%
    coffee={false},%
    nostains={false},%
    nonomencl={false},%
    nomencl={norefeq,norefpage,noprefix,intoc},%
    noxcolor={false},%
    xcolor={dvipsnames,svgnames,x11names},%
}

%% ----- process given options

\ProcessOptionsX

%% ----- package & class options

%% setup

\PassOptionsToClass{11pt,\eistaadoc@language}{book}

\ifeistaadoc@bookstyle% options depending on whether this is a book or not
    \PassOptionsToClass{titlepage,openright,twoside}{book}
    \PassOptionsToPackage{%
            a4paper,twoside,%
            hmarginratio=2:3,vmarginratio=2:3,% margin ratio: inner:outer
            outer=4.0cm,% outer margin width
            marginparsep=0.5cm,marginparwidth=3.0cm,% margin notes separator- and text width
            headsep=0.5cm,headheight=15.0pt% header separator- and text height
        }{geometry}
\else
    \PassOptionsToClass{notitlepage,openany}{book}
    \PassOptionsToPackage{%
            a4paper,reversemarginpar,%
            hmarginratio=1:1,vmarginratio=2:3,%
            hmargin=4.0cm,% equal horizontal margins
            marginparsep=0.5cm,marginparwidth=3.0cm,% margin notes separator- and text width
            headsep=0.5cm,headheight=15.0pt% header separator- and text height
        }{geometry}
\fi

\PassOptionsToPackage{\eistaadoc@language}{babel}

\PassOptionsToPackage{\eistaadoc@xcolor}{xcolor}

\PassOptionsToPackage{\eistaadoc@nomencl}{nomencl}

%% my classes

\PassOptionsToPackage{\eistaadoc@eistaasetup}{eistaasetup}

\PassOptionsToPackage{\eistaadoc@eistaacode}{eistaacode}
\PassOptionsToPackage{beramono=false}{eistaacode}  % do it in this class instead

\PassOptionsToPackage{\eistaadoc@eistaadrawing}{eistaadrawing}
\PassOptionsToPackage{xcolor={\eistaadoc@xcolor}}{eistaadrawing}
%% *}}}

%% --+-- base class & packages --+-- %% {{{* ----------------------------------
%%   \---------------------------/

%% load base class
\LoadClass{book}

% fixes to LaTeX2e
\RequirePackage{fixltx2e}

% fonts
\ifeistaadoc@normalfonts \else
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
\ifeistaadoc@noxcolor \else
    \RequirePackage{xcolor}
\fi

% used for styling
\RequirePackage{fancyhdr}               % to create custom header/footers
\RequirePackage{geometry}               % to mess with page geometry
\RequirePackage{titlesec}               % to style sections
\RequirePackage{chngcntr}               % control counters
\ifeistaadoc@coffee
    \RequirePackage{coffee4}
\fi

 % used for TODOS
 \RequirePackage{marginnote}            % for typing margin notes

% my standard setup
\ifx\eistaadoc@eistaasetup\@empty \else
    \RequirePackage{eistaasetup}
\fi
% my code setup
\ifx\eistaadoc@eistaacode\@empty \else
    \RequirePackage{eistaacode}
\fi
% my drawing setup
\ifx\eistaadoc@eistaadrawing\@empty \else
    \RequirePackage{eistaadrawing}
\fi

% improve spacing between words and letters
\RequirePackage{microtype}

% load enumitem if not loaded, since styling is dependant upon it
\@ifpackageloaded{enumitem}{ }{
    \RequirePackage{enumitem}           % to style lists
}

% load referencing packages
\ifeistaadoc@referencing
    \RequirePackage[capitalize]{cleveref}
    \RequirePackage{autonum}
\fi

% load nomencl
\ifeistaadoc@nonomencl \else
    \RequirePackage{nomencl}
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

\ifeistaadoc@bookstyle
    \renewcommand*{\maketitle}{
        \begin{titlepage}
            \null \vskip 2em%
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
            \ifeistaadoc@coffee
                \ifeistaadoc@nostains \else
                    \cofeAm{0.1}{1.0}{0}{4.5cm}{10.2cm}
                    \cofeCm{0.4}{0.7}{155}{0.0cm}{12.0cm}
                \fi
            \fi
        \end{titlepage}
    }
\else
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
        \ifeistaadoc@coffee
            \ifeistaadoc@nostains \else
                \cofeAm{0.1}{1.0}{0}{4.5cm}{10.2cm}
                \cofeCm{0.4}{0.7}{155}{0.0cm}{12.0cm}
            \fi
        \fi
    }
\fi
%% *}}}

%% --+-- styling --+-- %% {{{* ------------------------------------------------
%%   \-------------/

%% ----- marginnotes

% change the fontsize
\renewcommand*{\marginfont}{\footnotesize}

% todo-notes
\newcommand*{\todonote}[1]{%
    \ifeistaadoc@notodo \else
        \marginnote{\color{red}{TODO: #1}}
    \fi
}

%% ----- labels & numbering

% number within section
\@ifpackagewith{eistaasetup}{math}{    \counterwithin{equation}{section} }{ }
\@ifpackagewith{eistaasetup}{figures}{ \counterwithin{figure}{section}   }{ }
\counterwithin{table}{section}

% equation label
\@ifpackagewith{eistaasetup}{math}{
    % \let\old@tagform@=\tagform@
    % \def\tagform@#1{\maketag@@@{\hbox{\rlap{(\ignorespaces#1\unskip\@@italiccorr)\hspace{1mm}}}}\kern1sp}
    % %\def\tagform@#1{\hspace{0.1pt}\rlap{\hspace{0.5em}\old@tagform@{#1}}}
    % \renewcommand{\eqref}[1]{\textup{\old@tagform@{\ref{#1}}}}
}{ }

%% ----- list style

% make item use less space
\setlist[description]{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\setlist[enumerate]  {noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
\setlist[itemize]    {noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}
% add : after description label and make it boldface
\renewcommand{\descriptionlabel}[1]{\hspace{\labelsep}\textbf{#1:}}

%% ----- nomenclature/list of symbols

% change title to "List of Symbols"
\renewcommand*{\nomname}{List of Symbols}

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
    \ifeistaadoc@bookstyle \else
        \fancyfoot[L]{\ifthenelse{\value{page}=1}{\textit{Date:} \@@date}{}}
    \fi
    % pagenumber on every page
    \fancyfoot[C]{\thepage}
    % no header line but this footer line
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0.5pt}
}

%% ----- sections

% used to add a period after runin sections
\newcommand{\@periodafter}[1]{#1.}

% chapter
\renewcommand{\thechapter}{\Roman{chapter}}
\titleformat{\chapter}[display]% command & shape
    {\normalfont\Large\sc}% format
    {\filleft\MakeUppercase{\chaptertitlename} \Huge\thechapter}% label
    {1em}% separator between label & title body
    {\normalsize\hrule\vspace{1em}\filright\Large}% before code
    [\normalsize\vspace{1em}\hrule]% after code
% section
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
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
