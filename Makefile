
all:
	make html


PHONY: check
check:
	@juvix microjuvix typecheck index.mjuvix --only-errors --no-stdlib

PHONY: html
html:
	make check
	juvix html --output-dir=docs --recursive --print-metadata --no-stdlib index.mjuvix

PHONY: clean
clean:
	rm -rf docs