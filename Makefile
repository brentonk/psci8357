all : syllabus-psci-8357.pdf first-day-quiz.pdf

syllabus-psci-8357.pdf : syllabus-psci-8357.tex syllabus-body.tex
	latexmk -bibtex- syllabus-psci-8357
	latexmk -c

syllabus-body.tex : syllabus.md
	pandoc syllabus.md -o syllabus-body.tex

first-day-quiz.pdf : first-day-quiz.tex
	latexmk -bibtex- first-day-quiz
	latexmk -c
