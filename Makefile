FILE=main

LATEX=lualatex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all:
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;

