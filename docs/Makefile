DOC = Documentazione

Documentazione.pdf : $(DOC).tex
		pdflatex $(DOC).tex
		bibtex $(DOC)
		pdflatex $(DOC).tex


clean :
	rm -f $(DOC).aux $(DOC).idx $(DOC).ind \
	$(DOC).log $(DOC).toc $(DOC).out


delete:
	rm -f $(DOC).aux $(DOC).idx $(DOC).ind \
        $(DOC).log $(DOC).toc $(DOC).out \
	$(DOC).pdf
