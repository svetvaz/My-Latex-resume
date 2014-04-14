#!/bin/bash
# Auto compiler for tex files specified in a list
# Arvind A. de Menezes Pereira

function stripExtension() {
	res=`echo $1 | cut -d . -f 1`
	echo "${res}"
}

function doCompileFile() {
	pdflatex $1 
	fileExt = '.aux'
	fileName = $(stripExtension $1)
	file = ${fileName}${fileExt}
	if [ -z $file ]; then 
		bibtex $(stripExtension $1)${aux}
	fi 
	pdflatex $1 
	pdflatex $1 
}

function openFile() {
	FILE_WITHOUT_EXT=$(stripExtension $1)
	EXT='.pdf'
	FILE=${FILE_WITHOUT_EXT}${EXT}
	echo "Opening file "${FILE_WITHOUT_EXT}${FILE}
	open -a Preview ${FILE}
}

for i in "$@"
do
	doCompileFile $i
	openFile $i
done
