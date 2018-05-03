OUTPUT_DIR = docs
RMD_SLIDES = $(wildcard static/slides/*.Rmd)
PDF_SLIDES = $(RMD_SLIDES:%.Rmd=%.pdf)

check-html:
	htmlhint $(OUTPUT_DIR)

check-spelling:
	find $(OUTPUT_DIR) -name "*.html" -exec hunspell -L -i UTF-8 -d en_US -H -p WORDS -l '{}' \;

check-links:
	blc http://localhost:4321/ -ro

slides: $(PDF_SLIDES)

static/slides/%.pdf: static/slides/%.Rmd
	Rscript -e 'rmarkdown::render("$<")'
