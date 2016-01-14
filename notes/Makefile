notes = $(wildcard *.rmd)
pdfs = $(notes:.rmd=.pdf)

all : $(pdfs)

$(pdfs) : %.pdf : %.rmd _output.yaml ../charter-template.tex
	Rscript -e "library(rmarkdown); render('$<', output_format = 'all')"
