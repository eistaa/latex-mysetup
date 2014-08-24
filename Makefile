
TEXMF := $(shell kpsewhich --expand-path='$$TEXMFHOME')
TEXMFSUFFIX = tex/latex

## ----------------------------------------

SRCDIR         = ./src

ARTICLEDIR     = $(TEXMF)/$(TEXMFSUFFIX)/base
ARTICLEFILES   = eistaart.cls

CODESETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/eistaacode
CODESETUPFILES = eistaacode.sty

STDSETUPDIR    = $(TEXMF)/$(TEXMFSUFFIX)/eistaasetup
STDSETUPFILES  = eistaasetup.sty mathletters.sty

DRAWINGSETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/eistaadrawing
DRAWINGSETUPFILES = eistaadrawing.sty

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

