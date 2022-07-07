
all:
	make html


PHONY: check
check:
	@minijuvix microjuvix typecheck index.mjuvix --only-errors --no-stdlib

PHONY: html
html:
	make check
	minijuvix html --output-dir=docs --recursive --print-metadata --no-stdlib index.mjuvix

PHONY: clean
clean:
	rm -rf docs