VOL1=main-en-vol1
VOL2=main-en-vol2
PT_VOL1=main-pt-vol1

LATEX=lualatex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all:
	@echo "vol1, vol2, release or font-stress-test. Just say the word."

vol1:
	cat $(VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1).fir.tmp
	echo '\\contentsfinish' >> $(VOL1).fir.tmp
	mv $(VOL1).fir.tmp $(VOL1).fir
	$(LATEX) $(LATEX_OPTS) $(VOL1).tex;

vol1-retreat:
	cat $(VOL1)-retreat.fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1)-retreat.fir.tmp
	echo '\\contentsfinish' >> $(VOL1)-retreat.fir.tmp
	mv $(VOL1)-retreat.fir.tmp $(VOL1)-retreat.fir
	$(LATEX) $(LATEX_OPTS) $(VOL1)-retreat.tex;

vol2:
	cat $(VOL2).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL2).fir.tmp
	echo '\\contentsfinish' >> $(VOL2).fir.tmp
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

pt-partilha-sheet:
	$(LATEX) $(LATEX_OPTS) pt-partilha-sheet.tex;

pt:
	cat $(PT_VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(PT_VOL1).fir.tmp
	echo '\\contentsfinish' >> $(PT_VOL1).fir.tmp
	mv $(PT_VOL1).fir.tmp $(PT_VOL1).fir
	$(LATEX) $(LATEX_OPTS) $(PT_VOL1).tex;

pt-release:
	@echo -n "PT Vol 1 x4...."
	make pt && make pt && make pt && make pt

pt-puja:
	$(LATEX) $(LATEX_OPTS) main-pt-puja.tex;

pt-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-pt-vol1.tex;

pt-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-pt-vol1.tex;

chanting-sample-it:
	$(LATEX) $(LATEX_OPTS) chanting-sample-it.tex;

anapanasati-sheet-pali:
	$(LATEX) $(LATEX_OPTS) anapanasati-sheet-pali.tex;

sumedharama-monastic-chants:
	$(LATEX) $(LATEX_OPTS) sumedharama-monastic-chants.tex;
