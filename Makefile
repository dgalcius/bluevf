
default: 01.dvi 02.dvi

%.dvi: %.tex
	latex -recorder $<

%.pl: %.tfm
	tftopl $< >$@
