VOL1=main-en-vol1
VOL2=main-en-vol2

LATEX=lualatex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all:
	@echo "vol1, vol2 or font-stress-test. Just say the word."

vol1:
	cat $(VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1).fir.tmp
	echo '\\contentsfinish' >> $(VOL1).fir.tmp
	mv $(VOL1).fir.tmp $(VOL1).fir
	$(LATEX) $(LATEX_OPTS) $(VOL1).tex;

vol2:
	cat $(VOL2).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL2).fir.tmp
	echo '\\contentsfinish' >> $(VOL2).fir.tmp
	mv $(VOL2).fir.tmp $(VOL2).fir
	$(LATEX) $(LATEX_OPTS) $(VOL2).tex;

font-stress-test:
	$(LATEX) $(LATEX_OPTS) font-stress-test.tex;

part-pages-test:
	$(LATEX) $(LATEX_OPTS) part-pages-test.tex;

