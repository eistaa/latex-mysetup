\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myarticle}

\RequirePackage{etoolbox}               % logic & booleans


%%   +-----------+
%% ----- setup ----- %% -------------------------------------------------------
%%   +-----------+


%% ----- setup options

%% defaults
\PassOptionsToClass  {11pt}   {article}
\PassOptionsToClass  {twoside}{article}
\PassOptionsToClass  {a4paper}{article}
\PassOptionsToPackage{a4paper}{geometry}

%% declare options
% load my standard setup
\providebool{@stdsetup}
\boolfalse  {@stdsetup}
\DeclareOption{stdsetup}{ \booltrue{@stdsetup} }
\DeclareOption{nomathletters}{ \PassOptionToPackage{nomathletters}{stdsetup} }
% whether to load my code setup
\providebool{@codesetup}
\boolfalse  {@codesetup}
\DeclareOption{codesetup}{ \booltrue{@codesetup} }
% whether to load my tikz setup
\providebool{@tikzsetup}
\boolfalse  {@tikzsetup}
\DeclareOption{tikzsetup}{ \booltrue{@tikzsetup} }
% whether to use normal fonts (default is to use special setup)
\providebool{@normalfont}
\boolfalse  {@normalfont}
\DeclareOption{normalfont}{ \booltrue{@normalfont} }

%% execute default options

%% process given options

\ProcessOptions\relax


%% ----- load base class & packages

%% load base class
\LoadClass{article}

%% load packages

% fonts
\notbool{@normalfont}{
    % use special fonts
    \RequirePackage[sc]{mathpazo}       % use adobe palatino familly of fonts with true small caps
    \linespread{1.05}                   % palatino needs more leading (space between lines)
    \RequirePackage[euler-hat-accent]
                   {eulervm}            % use ams euler font for math
    \RequirePackage{beramono}           % use beramono as monospace font. supports bold and italic
}{ }

% encoding & language
\RequirePackage[utf8]   {inputenc}      % input encoding is utf-8
\RequirePackage[T1]     {fontenc}       % encode fonts as T1
\RequirePackage[english]{babel}         % we write in english

% used for styling
\RequirePackage{fancyhdr}               % to create custom header/footers
\RequirePackage[hmarginratio=1:1,margin=1.5in,headheight=15.0pt]
               {geometry}               % to mess with page geometry
\RequirePackage{titlesec}               % to style sections
\RequirePackage[inline]{enumitem}       % to style lists

% my standard setup
\ifbool{@stdsetup}{
    \RequirePackage{stdsetup}
}{ }
% my code setup
\ifbool{@codesetup}{
    \RequirePackage{codesetup}
}{ }
% my tikz setup
\ifbool{@tikzsetup}{ 
    \RequirePackage{tikzsetup}
}{ }


%%   +--------------+
%% ----- commands ----- %% ----------------------------------------------------
%%   +--------------+


%% title command (from amsart class)
%  - defines \@shorttitle and \@title commands
\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\edef\title{\noexpand\@dblarg
    \expandafter\noexpand\csname\string\title\endcsname}

% to be able to access author name in the class file
\renewcommand*{\author}[1]{\gdef\@author{#1}\gdef\@@author{#1}}
\let\@@author\@empty

% to be able to access date in the class file
\renewcommand*{\date}[1]{\gdef\@date{#1}\gdef\@@date{#1}}
\let\@@date\@empty


%%   +-------------+
%% ----- styling ----- %% -----------------------------------------------------
%%   +-------------+


%% ----- numbering

% number within section
\ifbool{@stdsetup}{
    \numberwithin{equation}{section}
}{ }
\numberwithin{figure}{section}
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
\renewcommand{\headrulewidth}{1pt} % 2pt thick line after header
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
    \fancyfoot[L]{\ifthenelse{\value{page}=1}{\textit{Date:} \@@date}{}}
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
        \rule{0.7\textwidth}{0.5pt} \\
        \Large\sc\@title            \\
        \rule{0.7\textwidth}{0.5pt} \\
        \vskip 1em
        \large\sc\@@author
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

