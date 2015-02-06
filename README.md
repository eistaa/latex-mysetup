latex-mysetup
=============

My latex setup. Classes and packages tuned to my usage.

Copyright Eivind Storm Aarnæs, eiv(DOT)s(DOT)aa(AT)gmail(DOT)com.  
Licensed under [The LaTeX Project Public License](http://latex-project.org/lppl/).

Files
-----

This work consist of the following files:

 * `eistaart.cls` -- An article class styling the document the way I prefer.
 * `eistaasetup.sty` -- A package containing my usual math, text, theorem and figure setup.
   * `mathletters.sty` -- Convenient shorthands to some math letters.
 * `eistaacode.sty` -- A package for formating code the way I like it, either with `listings` or
   with `minted`.
 * `eistaadrawing.sty` -- A package for drawing related stuff. Currently only TiKZ.

Installing
----------

These instruction assume you are using [TeX Live](https://www.tug.org/texlive/) as your LaTeX
distribution.

The makefile is set up to install to the users local `texmf`-directory by default. Before running
the makefile you should run:

```bash
tlmgr init-usertree             # to setup your local texmf dir
kpsewhich -var-value=TEXMFHOME  # this should output the path to your local texmf dir
```

To install to your local `texmf`-directory, do:

```bash
make install
```

To install to a different `texmf`-directory, do:

```bash
make -e TEXMF=path/to/texmf install
```

Required Packages
-----------------

This is a table of directly required packages:

| Package           | `eistaart`      | `eistaasetup`   | `eistaacode`    | `eistaadrawing` |
|:----------------- |:---------------:|:---------------:|:---------------:|:---------------:|
| `algorithm2e`     |                 | YES             |                 |                 |
| `amsfonts`        |                 | YES             |                 |                 |
| `amsmath`         |                 | YES             |                 |                 |
| `amssymb`         |                 | YES             |                 |                 |
| `amsthm`          |                 | YES             |                 |                 |
| `babel`           | YES             |                 |                 |                 |
| `beramono`        | YES             |                 | YES             |                 |
| `chngcntr`        | YES             |                 |                 |                 |
| `enumitem`        | YES             | YES             |                 |                 |
| `eulervm`         | YES             |                 |                 |                 |
| `fancyhdr`        | YES             |                 |                 |                 |
| `fontenc`         | YES             |                 | YES             |                 |
| `geometry`        | YES             |                 |                 |                 |
| `graphicx`        |                 | YES             |                 |                 |
| `inputenc`        | YES             |                 |                 |                 |
| `kvoptions-patch` | YES             | YES             | YES             | YES             |
| `listings`        |                 |                 | YES             |                 |
| `mathpazo`        | YES             |                 |                 |                 |
| `mathtools`       |                 | YES             |                 |                 |
| `minted`          |                 |                 | YES             |                 |
| `subcaption`      |                 | YES             |                 |                 |
| `thmtools`        |                 | YES             |                 |                 |
| `tikz`            |                 |                 |                 | YES             |
| `titlesec`        | YES             |                 |                 |                 |
| `xcolor`          |                 |                 | YES             | YES             |
| `xkeyval`         | YES             | YES             | YES             | YES             |

Usage
-----

### `eistaasetup`

```latex
\usepackage[%
        figures,math,theorem,text,% to load parts of the package
        enumitem={inline}% options to enumitem
    ]{eistaasetup}
```

#### Options

 * `figures` -- Enable by passing option to package.
   * Loads [graphix](http://ctan.org/pkg/graphicx) and [subcaption](http://ctan.org/pkg/graphicx).
 * `math` -- Enable by passing option to package.
   * Loads [amsmath](http://ctan.org/pkg/graphicx), [amsfonts & amssymb](http://ctan.org/pkg/amsfonts),
     [mathtools](http://ctan.org/pkg/mathtools), [algorithm2e](http://ctan.org/pkg/algorithm2e)
     packages.
   * Also loads shorthands to math letters, see `mathletters`-package.
   * Defines a lot of math operators and other math commands.
 * `theorems` -- Enable by passing option to package.
   * Loads [amsthm](http://ctan.org/pkg/amsthm) and [thmtools](http://ctan.org/pkg/thmtools)
     packages.
   * Defines and applies a theorem style where the type label hangs out in the margin.
   * Defines the following environments: `theorem`, `definition`, `lemma`, `preposition`, `example`.
 * `text` -- Enable by passing option to package.
   * Loads [enumitem](http://ctan.org/pkg/enumitem) package.
   * Defines two macros: `qte` and `itqte` for quoting text.
   * Defines two list environments: `romanenum` and `romanenuminline`. Lists using small roman numerals,
     the inline version is only defined if `enumitem` is loaded with `inline` option.
 * `enumitem` -- Pass options to `enumitem` package. If not specified loaded with `inline`.

### `eistaacode`



### `eistaadrawing`



### `eistaart`


