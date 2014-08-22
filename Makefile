
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

DRAWINGSETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/drawingsetup
DRAWINGSETUPFILES = drawingsetup.sty

## ----------------------------------------

ARTICLESRC      = $(patsubst %,$(SRCDIR)/%,$(ARTICLEFILES))
CODESETUPSRC    = $(patsubst %,$(SRCDIR)/%,$(CODESETUPFILES))
STDSETUPSRC     = $(patsubst %,$(SRCDIR)/%,$(STDSETUPFILES))
DRAWINGSETUPSRC = $(patsubst %,$(SRCDIR)/%,$(DRAWINGSETUPFILES))

## ----------------------------------------

.PHONY: install article std code drawing

install: article std code drawing
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

drawing: $(DRAWINGSETUPSRC) | $(DRAWINGSETUPDIR)
	cp -p $(DRAWINGSETUPSRC) $(DRAWINGSETUPDIR)
$(DRAWINGSETUPDIR):
	mkdir -p $(DRAWINGSETUPDIR)

