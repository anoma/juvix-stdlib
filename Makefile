
all:
	make html


PHONY: check
check:
	@juvix microjuvix typecheck index.juvix --only-errors --no-stdlib

PHONY: html
html:
	make check
	juvix html --output-dir=docs --recursive --print-metadata --no-stdlib index.juvix

PHONY: clean
clean:
	rm -rf docs
