
COPY    := cp
MKDIR   := mkdir -p  # also make parent directories as needed
TEXHASH := texhash

# change this line to determine where to install
TEXMF       := $(shell kpsewhich -var-value=TEXMFHOME)
TEXMFSUFFIX  = tex/latex

## ----------------------------------------

SRCDIR   = ./src
OTHERDIR = ./other

# CLASSDIR   = $(TEXMF)/$(TEXMFSUFFIX)/base

CLSFILES  = eistaadoc.cls
STYFILES  = eistaasetup.sty mathletters.sty
STYFILES += eistaacode.sty
STYFILES += eistaadrawing.sty
PKGDIR    = $(TEXMF)/$(TEXMFSUFFIX)/eistaa

# for bundled packages

COFFEEFILES = coffee4.sty
COFFEEDIR   = $(TEXMF)/$(TEXMFSUFFIX)/coffee4

## ----------------------------------------

STYSRC    = $(patsubst %,$(SRCDIR)/%,$(STYFILES))
CLSSRC    = $(patsubst %,$(SRCDIR)/%,$(CLSFILES))
COFFEESRC = $(patsubst %,$(OTHERDIR)/%,$(COFFEEFILES))

## ----------------------------------------

.PHONY: install cp-class class cp-package package cp-bundled bundled
.PHONY: $(PKGDIR) $(COFFEESRC) $(COFFEEDIR)

install: cp-class cp-package cp-bundled
	$(TEXHASH) $(TEXMF)

# install class(es)
class: cp-class cp-package $(COFFEFILES)
	$(TEXHASH) $(TEXMF)
cp-class: $(CLSSRC) | $(PKGDIR)
	$(COPY) $(CLSSRC) $(PKGDIR)
# install packages(es)
package: cp-class
	$(TEXHASH) $(TEXMF)
cp-package: $(STYSRC) | $(PKGDIR)
	$(COPY) $(STYSRC) $(PKGDIR)

# create package directory
$(PKGDIR):
	$(MKDIR) $(PKGDIR)

# install bundled packages
bundled: cp-bundled
	$(TEXHASH) $(TEXMF)
cp-bundled: $(COFFEESRC)

# install the coffe4 package
$(COFFEESRC): | $(COFFEEDIR)
	$(COPY) $(COFFEESRC) $(COFFEEDIR)
$(COFFEEDIR):
	$(MKDIR) $(COFFEEDIR)
