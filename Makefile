
DOC=paper
DVIPS=dvips
ALLTEX=$(wildcard *.tex)
REDUCE=psnup -n 2

ps: $(DOC).ps

all: $(DOC).dvi 

spelling: 
	ispell -t $(ALLTEX)
clean:
	rm -f $(DOC).dvi $(DOC).aux *.aux $(DOC).log $(DOC).bbl $(DOC).blg \
	$(DOC).ps \
	$(DOC).lot $(DOC).lof $(DOC).toc $(DOC).synctex.gz
	
view: $(DOC).ps
	gv $(DOC).ps &

$(DOC).ps: $(DOC).dvi
	$(DVIPS) $(DOC).dvi -o $(DOC).ps

$(DOC).2.ps: $(DOC).ps
	$(REDUCE) $(DOC).ps > $(DOC).2.ps

$(DOC).aux: $(ALLTEX)
	latex $(DOC)

$(DOC).bbl: $(DOC).bib $(DOC).aux
	bibtex $(DOC)
	latex $(DOC)

$(DOC).dvi: $(DOC).tex $(DOC).bbl
	latex $(DOC)

