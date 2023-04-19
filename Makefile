
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

TOFORMATJUVIXFILES = ./Stdlib
TOFORMAT = $(shell find ${TOFORMATJUVIXFILES} -name "*.juvix" -print)

.PHONY: $(TOFORMAT)
juvix-format: $(TOFORMAT)
$(TOFORMAT): %:
	@echo "Formatting $@"
	@juvix dev scope $@ --with-comments > $@.tmp
	@echo "" >> $@.tmp
	@mv $@.tmp $@
	@echo "Typechecking formatted $@"
	@juvix typecheck $@ --only-errors

.PHONY: test
test:
	$(MAKE) -C test/
