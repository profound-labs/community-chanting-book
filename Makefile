FILE=main-en-vol2

LATEX=lualatex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all:
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;

