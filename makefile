all: doc test

doc: doc/manual.six

doc/manual.six: createautodoc.g makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/D-Modules.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g examples/doc/*.g
	        gap createautodoc.g
		gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/D-Modules.tar.gz --exclude ".DS_Store" --exclude "*~" D-Modules/doc/*.* D-Modules/doc/clean D-Modules/gap/*.{gi,gd} D-Modules/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g,createautodoc.g} D-Modules/examples/*.g D-Modules/examples/doc/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/D-Modules

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.D-Modules
	cp doc/manual.pdf ${WEBPOS}/D-Modules.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/D-Modules.tar.gz ${WEBPOS}/D-Modules-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s D-Modules-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/D-Modules.tar.gz

