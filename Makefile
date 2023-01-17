
all: check html

PHONY: check
check:
	@juvix typecheck index.juvix --only-errors --no-stdlib

PHONY: html
html:
	@juvix --no-stdlib html --theme ayu --output-dir=docs/ index.juvix

PHONY: clean
clean:
	rm -rf docs
