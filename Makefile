
COPY    := cp
MKDIR   := mkdir -p  # also make parent directories as needed
TEXHASH := texhash

# change this line to determine where to install
TEXMF := $(shell kpsewhich -var-value=TEXMFHOME)
TEXMFSUFFIX = tex/latex

## ----------------------------------------

SRCDIR         = ./src

CLASSDIR       = $(TEXMF)/$(TEXMFSUFFIX)/base
CLASSFILES     = eistaart.cls

CODESETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/eistaacode
CODESETUPFILES = eistaacode.sty

STDSETUPDIR    = $(TEXMF)/$(TEXMFSUFFIX)/eistaasetup
STDSETUPFILES  = eistaasetup.sty mathletters.sty

DRAWINGSETUPDIR   = $(TEXMF)/$(TEXMFSUFFIX)/eistaadrawing
DRAWINGSETUPFILES = eistaadrawing.sty

## ----------------------------------------

CLASSSRC        = $(patsubst %,$(SRCDIR)/%,$(CLASSFILES))
CODESETUPSRC    = $(patsubst %,$(SRCDIR)/%,$(CODESETUPFILES))
STDSETUPSRC     = $(patsubst %,$(SRCDIR)/%,$(STDSETUPFILES))
DRAWINGSETUPSRC = $(patsubst %,$(SRCDIR)/%,$(DRAWINGSETUPFILES))

## ----------------------------------------

.PHONY: install article std code drawing

install: article std code drawing
	$(TEXHASH) $(TEXMF)

article: $(CLASSSRC) | $(CLASSDIR)
	$(COPY) $(CLASSSRC) $(CLASSDIR)
$(CLASSDIR):
	$(MKDIR) $(CLASSDIR)

std: $(STDSETUPSRC) | $(STDSETUPDIR)
	$(COPY) $(STDSETUPSRC) $(STDSETUPDIR)
$(STDSETUPDIR):
	$(MKDIR) $(STDSETUPDIR)

code: $(CODESETUPSRC) | $(CODESETUPDIR)
	$(COPY) $(CODESETUPSRC) $(CODESETUPDIR)
$(CODESETUPDIR):
	$(MKDIR) $(CODESETUPDIR)

drawing: $(DRAWINGSETUPSRC) | $(DRAWINGSETUPDIR)
	$(COPY) $(DRAWINGSETUPSRC) $(DRAWINGSETUPDIR)
$(DRAWINGSETUPDIR):
	$(MKDIR) $(DRAWINGSETUPDIR)

