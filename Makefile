VOL1=main-en-vol1
VOL1_A4=main-en-vol1-a4
VOL2=main-en-vol2
PT_VOL1=main-pt-vol1
TH_VOL1=main-th-vol1
TH_VOL2=main-th-vol2

LATEX=lualatex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error

TH_LATEX=xelatex
TH_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -output-driver='xdvipdfmx -z0'

# TH_LATEX=latexmk
# TH_LATEX_OPTS=-interaction=nonstopmode -halt-on-error -xelatex

all:
	@echo "vol1, vol2, release or font-stress-test. Just say the word."

%.pdf: %.tex
	$(LATEX) $(LATEX_OPTS) $<

vol1:
	cat $(VOL1).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1).fir.tmp
	echo '\\contentsfinish' >> $(VOL1).fir.tmp
	mv $(VOL1).fir.tmp $(VOL1).fir

vol1-a4:
	cat $(VOL1_A4).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(VOL1_A4).fir.tmp
	echo '\\contentsfinish' >> $(VOL1_A4).fir.tmp
	mv $(VOL1_A4).fir.tmp $(VOL1_A4).fir
	$(LATEX) $(LATEX_OPTS) $(VOL1_A4).tex;

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
	echo '\contentsfinish' >> $(PT_VOL1).fir.tmp
	mv $(PT_VOL1).fir.tmp $(PT_VOL1).fir
	$(LATEX) $(LATEX_OPTS) $(PT_VOL1).tex;

pt-release:
	@echo -n "PT Vol 1 x4...."
	make pt && make pt && make pt && make pt

pt-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-pt-vol1.tex;

pt-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-pt-vol1.tex;

th-preview:
	./helpers/th-preview.sh


#	cat $(TH_VOL1).fir | \
#		sed '/\\contentsfinish/d' | \
#		sort > $(TH_VOL1).fir.tmp
#	echo '\contentsfinish' >> $(TH_VOL1).fir.tmp
#	mv $(TH_VOL1).fir.tmp $(TH_VOL1).fir
th-vol1:
	$(TH_LATEX) $(TH_LATEX_OPTS) $(TH_VOL1).tex;

th-vol1-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-th-vol1.tex;

th-vol1-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-th-vol1.tex;

th-vol2:
	cat $(TH_VOL2).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(TH_VOL2).fir.tmp
	echo '\contentsfinish' >> $(TH_VOL2).fir.tmp
	mv $(TH_VOL2).fir.tmp $(TH_VOL2).fir
	$(TH_LATEX) $(TH_LATEX_OPTS) $(TH_VOL2).tex;

th-vol2-cover-front:
	$(LATEX) $(LATEX_OPTS) cover-front-th-vol2.tex;

th-vol2-cover-back:
	$(LATEX) $(LATEX_OPTS) cover-back-th-vol2.tex;

chanting-sample-it:
	$(LATEX) $(LATEX_OPTS) chanting-sample-it.tex;

anapanasati-sheet-pali:
	$(LATEX) $(LATEX_OPTS) anapanasati-sheet-pali.tex;

sumedharama-monastic-chants:
	$(LATEX) $(LATEX_OPTS) sumedharama-monastic-chants.tex;

brazil-chants:
	$(LATEX) $(LATEX_OPTS) brazil-chants.tex;

satipatthana:
	$(LATEX) $(LATEX_OPTS) satipatthana-en.tex;
