source = rnaseq-normalization.rmd
presentation = ${source:.rmd=.html}
notebook = ${source:.rmd=.nb.html}
presentation-files = presentation.css gfx/nuts.png
rsconnect_config = $(shell ./scripts/rsconnect-config-file ${notebook})

all: presentation notebook

.PHONY: presentation
presentation: ${presentation}

.PHONY: notebook
notebook: ${notebook}

.PHONY: publish

publish: ${rsconnect_config}

${rsconnect_config}: ${notebook}
	./scripts/publish-to-rpubs "$<"

render = Rscript -e "library(methods); rmarkdown::render('$2', '$1', '$3')"

${presentation}: ${source} ${presentation-files}
	$(call render,revealjs::revealjs_presentation,$<,$@)

${notebook}: ${source}
	$(call render,html_notebook,$<,$@)

.DELETE_ON_ERROR:
