
default: 01.blue.dvi

defaultx: 01.dvi 02.dvi

%.blue.dvi: %.dvi

test-blue.tex:
	mustache data.yml tmpl.mustache >$@

blue-cmr10.tfm: test-blue.tex
	etex $<
	vptovf blue-cmr10.vpl

red-cmr10.tfm: test-red.tex
	etex $<
	vptovf red-cmr10.vpl

%.dvi: %.tex
	latex -recorder $<

%.pl: %.tfm
	tftopl $< >$@

01: cmr10.pl

02:
	tex test.tex

%.dvi: %.tex
	latex $<

%.ps: %.dvi
	dvips -j0 $<

%.pdf: %.ps
	ps2pdf $<

diff:
#	diff --help > diff.help
	diff -d -I pre test02.d test02.dt > diff.txt || true
diff2:
#	diff --help > diff.help
	diff --old-group-format="D %<" \
--new-group-format="I %>" \
--changed-group-format="CHANGED%c'\012'%>%<END%c'\012'" \
--unchanged-group-format="%<" -I pre test02.d test02.dt > diff.txt || true

diff3:
#	diff --help > diff.help
	diff --old-line-format="D %<" \
--new-line-format="I %>" \
--changed-line-format="CHANGED%c'\012'%>END%c'\012'" \
--unchanged-ine-format="%<" -I pre test02.d test02.dt > diff.txt || true
