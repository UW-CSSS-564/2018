OUTPUT_DIR = docs

check-html:
	htmlhint $(OUTPUT_DIR)

check-spelling:
	find $(OUTPUT_DIR) -name "*.html" -exec hunspell -L -i UTF-8 -d en_US -H -p WORDS -l '{}' \;

check-links:
	blc http://localhost:4321/ -ro
