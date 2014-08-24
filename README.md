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
tlmgr init-userdir              # to setup your local texmf dir
kpsewhich -var-value=TEXMFHOME  # this should output the path to your local texmf dir
```

To install your local `texmf`-directory, do:

```bash
make install
```

To install to a different `texmf`-directory, do:

```bash
make -e TEXMF=path/to/texmf install
```

Usage
-----

TODO
