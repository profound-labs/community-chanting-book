VOL1=main-en-vol1
VOL1_A4=main-en-vol1-a4
VOL2=main-en-vol2
PT_VOL1=main-pt-vol1
ES_VOL1=main-es-vol1
ES_VOL2=main-es-vol2
TH_VOL1=main-th-vol1

# LATEX=lualatex
# LATEX_OPTS=-interaction=nonstopmode -halt-on-error

LATEX=xelatex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

# TH_LATEX=xelatex
# TH_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -output-driver='xdvipdfmx -z0'

TH_LATEX=latexmk
TH_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

# PT_LATEX=latexmk
# PT_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

PT_LATEX=xelatex
PT_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

ES_LATEX=xelatex
ES_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

# PT_LATEX=lualatex
# PT_LATEX_OPTS=-interaction=nonstopmode -halt-on-error

# lualatex --version
# This is LuaHBTeX, Version 1.13.2 (TeX Live 2021)

# xelatex --version
# XeTeX 3.141592653-2.6-0.999993 (TeX Live 2021)

all:
	@echo "Make what?"

%.pdf: %.tex
	$(LATEX) $(LATEX_OPTS) $<

vol1-ebooks:
	./helpers/ebooks.sh "chapters/english/markdown-vol1/book.toml"

vol2-ebooks:
	./helpers/ebooks.sh  "chapters/english/markdown-vol2/book.toml"

pt-ebooks:
	./helpers/ebooks.sh "chapters/portuguese/markdown/book.toml"

satipatthana-ebooks:
	./helpers/ebooks.sh "chapters/english/markdown-satipatthana/book.toml"

ebooks: vol1-ebooks vol2-ebooks pt-ebooks satipatthana-ebooks

vol1:
	cat $(VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1).fir.tmp
	echo '\contentsfinish' >> $(VOL1).fir.tmp
	mv $(VOL1).fir.tmp $(VOL1).fir
	$(LATEX) $(LATEX_OPTS) $(VOL1).tex;

vol1-a4:
	cat $(VOL1_A4).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1_A4).fir.tmp
	echo '\contentsfinish' >> $(VOL1_A4).fir.tmp
	mv $(VOL1_A4).fir.tmp $(VOL1_A4).fir
	$(LATEX) $(LATEX_OPTS) $(VOL1_A4).tex;

vol1-retreat:
	cat $(VOL1)-retreat.fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1)-retreat.fir.tmp
	echo '\contentsfinish' >> $(VOL1)-retreat.fir.tmp
	mv $(VOL1)-retreat.fir.tmp $(VOL1)-retreat.fir
	$(LATEX) $(LATEX_OPTS) $(VOL1)-retreat.tex;

vol2:
	cat $(VOL2).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL2).fir.tmp
	echo '\contentsfinish' >> $(VOL2).fir.tmp
	mv $(VOL2).fir.tmp $(VOL2).fir
	$(LATEX) $(LATEX_OPTS) $(VOL2).tex;

release:
	@echo -n "Vol 1 x4...."
	make vol1 && make vol1 && make vol1 && make vol1
	@echo -n "Vol 2 x4...."
	make vol2 && make vol2 && make vol2 && make vol2

font-stress-test:
	$(LATEX) $(LATEX_OPTS) font-stress-test.tex;

part-pages-test:
	$(LATEX) $(LATEX_OPTS) part-pages-test.tex;

pt:
	cat $(PT_VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(PT_VOL1).fir.tmp
	echo '\contentsfinish' >> $(PT_VOL1).fir.tmp
	mv $(PT_VOL1).fir.tmp $(PT_VOL1).fir
	$(PT_LATEX) $(PT_LATEX_OPTS) $(PT_VOL1).tex;

pt-release:
	@echo -n "PT Vol 1 x4...."
	make pt && make pt && make pt && make pt

pt-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-pt-vol1.tex;

pt-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-pt-vol1.tex;

es:
	cat $(ES_VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(ES_VOL1).fir.tmp
	echo '\contentsfinish' >> $(ES_VOL1).fir.tmp
	mv $(ES_VOL1).fir.tmp $(ES_VOL1).fir
	$(ES_LATEX) $(ES_LATEX_OPTS) $(ES_VOL1).tex;

es-vol2:
	cat $(ES_VOL2).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(ES_VOL2).fir.tmp
	echo '\contentsfinish' >> $(ES_VOL2).fir.tmp
	mv $(ES_VOL2).fir.tmp $(ES_VOL2).fir
	$(ES_LATEX) $(ES_LATEX_OPTS) $(ES_VOL2).tex;

es-vol1-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-es-vol1.tex;

es-vol1-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-es-vol1.tex;

es-vol2-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-es-vol2.tex;

es-vol2-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-es-vol2.tex;

th:
	cat $(TH_VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(TH_VOL1).fir.tmp
	echo '\contentsfinish' >> $(TH_VOL1).fir.tmp
	mv $(TH_VOL1).fir.tmp $(TH_VOL1).fir
	$(TH_LATEX) $(TH_LATEX_OPTS) $(TH_VOL1).tex;

th-preview:
	./helpers/th-preview.sh

satipatthana:
	$(LATEX) $(LATEX_OPTS) satipatthana-en.tex;

satipatthana-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-satipatthana.tex;

satipatthana-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-satipatthana.tex;

aparihaniya:
	$(LATEX) $(LATEX_OPTS) aparihaniya-en.tex;
