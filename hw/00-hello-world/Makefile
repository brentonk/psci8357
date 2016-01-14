all : README.pdf

README.pdf README.md : README.rmd ../../charter-template.tex
	Rscript -e "library(rmarkdown); render('README.rmd', output_format = 'all')"
