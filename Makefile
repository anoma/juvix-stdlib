SHELL := /bin/bash
JUVIXBIN?=juvix

all: check html

PHONY: check
check:
	@${JUVIXBIN} typecheck index.juvix --only-errors --no-stdlib

PHONY: html
html:
	@${JUVIXBIN} --no-stdlib html --theme ayu --output-dir=docs/ index.juvix

PHONY: clean
clean:
	rm -rf docs

.PHONY: test
test:
	$(MAKE) -C test/

JUVIXFILES?=$(shell find \
	./Stdlib ./test \
	-type d \( -name ".juvix-build" -o -name "deps" \) -prune -o \
	-type f -name "*.juvix" -print)

JUVIXFORMATFLAGS?=--in-place
JUVIXTYPECHECKFLAGS?=--only-errors

.PHONY: format-juvix-files
format-juvix-files:
	@for file in $(JUVIXFILES); do \
		${JUVIXBIN} format $(JUVIXFORMATFLAGS) "$$file" > /dev/null 2>&1; \
		exit_code=$$?; \
		if [ $$exit_code -eq 0 ]; then \
			echo "[OK] $$file"; \
      	else \
 			echo "[FAIL] $$file formatting failed"; \
      	fi; \
      	done;

.PHONY: check-format-juvix-files
check-format-juvix-files:
	@JUVIXFORMATFLAGS=--check ${MAKE} format-juvix-files

.PHONY: typecheck-juvix-files
typecheck-juvix-files:
	@for file in $(JUVIXFILES); do \
		${JUVIXBIN} typecheck "$$file" $(JUVIXTYPECHECKFLAGS); \
		exit_code=$$?; \
		if [ $$exit_code -eq 0 ]; then \
			echo "[OK] $$file typechecks"; \
		else \
 			echo "[FAIL] Typecking failed for $$file" && exit 1 ; \
      	fi; \
	done

