
TEXMF := $(shell kpsewhich --expand-path='$$TEXMFHOME')
TEXMFSUFFIX = tex/latex

## ----------------------------------------

SRCDIR         = ./src

ARTICLEDIR     = $(TEXMF)/$(TEXMFSUFFIX)/base
ARTICLEFILES   = myarticle.cls

CODESETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/codesetup
CODESETUPFILES = codesetup.sty

STDSETUPDIR    = $(TEXMF)/$(TEXMFSUFFIX)/stdsetup
STDSETUPFILES  = stdsetup.sty mathletters.sty

TIKZSETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/tikzsetup
TIKZSETUPFILES = tikzsetup.sty

## ----------------------------------------

ARTICLESRC   = $(patsubst %,$(SRCDIR)/%,$(ARTICLEFILES))
CODESETUPSRC = $(patsubst %,$(SRCDIR)/%,$(CODESETUPFILES))
STDSETUPSRC  = $(patsubst %,$(SRCDIR)/%,$(STDSETUPFILES))
TIKZSETUPSRC = $(patsubst %,$(SRCDIR)/%,$(TIKZSETUPFILES))

## ----------------------------------------

.PHONY: install article std code tikz

install: article std code tikz
	texhash $(TEXMF)

article: $(ARTICLESRC) | $(ARTICLEDIR)
	cp -p $(ARTICLESRC) $(ARTICLEDIR)
$(ARTICLEDIR):
	mkdir -p $(ARTICLEDIR)

std: $(STDSETUPSRC) | $(STDSETUPDIR)
	cp -p $(STDSETUPSRC) $(STDSETUPDIR)
$(STDSETUPDIR):
	mkdir -p $(STDSETUPDIR)

code: $(CODESETUPSRC) | $(CODESETUPDIR)
	cp -p $(CODESETUPSRC) $(CODESETUPDIR)
$(CODESETUPDIR):
	mkdir -p $(CODESETUPDIR)

tikz: $(TIKZSETUPSRC) | $(TIKZSETUPDIR)
	cp -p $(TIKZSETUPSRC) $(TIKZSETUPDIR)
$(TIKZSETUPDIR):
	mkdir -p $(TIKZSETUPDIR)

