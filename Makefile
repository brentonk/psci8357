all : syllabus-psci-8357.pdf

syllabus-psci-8357.pdf : syllabus-psci-8357.tex syllabus-body.tex
	latexmk -bibtex- syllabus-psci-8357
	latexmk -c

syllabus-body.tex : syllabus.md
	pandoc syllabus.md -o syllabus-body.tex
