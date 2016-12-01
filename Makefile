source = rnaseq-normalization.rmd
presentation = ${source:.rmd=.html}
notebook = ${source:.rmd=.nb.html}
presentation-files = presentation.css gfx/nuts.png

all: presentation notebook

.PHONY: presentation
presentation: ${presentation}

.PHONY: notebook
notebook: ${notebook}

render = Rscript -e "library(methods); rmarkdown::render('$2', '$1', '$3')"

${presentation}: ${source} ${presentation-files}
	$(call render,revealjs::revealjs_presentation,$<,$@)

${notebook}: ${source}
	$(call render,html_notebook,$<,$@)

.DELETE_ON_ERROR:
