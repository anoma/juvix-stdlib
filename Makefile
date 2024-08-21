SHELL := /bin/bash
JUVIXBIN?=juvix

all: check html

PHONY: check
check:
	@${JUVIXBIN} typecheck index.juvix --log-level error --no-stdlib

PHONY: html
html:
	@${JUVIXBIN} --no-stdlib html --output-dir=docs/ index.juvix

PHONY: clean
clean:
	rm -rf docs
	$(MAKE) -C test/ clean

.PHONY: test
test:
	$(MAKE) -C test/

JUVIXFILES?=$(shell find \
	./Stdlib ./test \
	-type d \( -name ".juvix-build" -o -name "deps" \) -prune -o \
	-type f -name "*.juvix" -print)

JUVIXFORMATFLAGS?=--in-place
JUVIXTYPECHECKFLAGS?=--log-level error
FORMATCHECK?=0

.PHONY: format
format:
	@for file in $(JUVIXFILES); do \
		${JUVIXBIN} format $(JUVIXFORMATFLAGS) "$$file" > /dev/null 2>&1; \
		exit_code=$$?; \
		if [ $$exit_code -eq 0 ]; then \
			echo "[OK] $$file is formatted"; \
		elif [ $$exit_code -eq 1 ] && [ $(FORMATCHECK) -eq 0 ]; then \
			echo "[OK] $$file was formatted"; \
	  	else \
			echo "[FAIL] $$file formatting failed" && exit 1; \
		fi; \
		done;

.PHONY: check-format
check-format: FORMATCHECK=1
check-format: JUVIXFORMATFLAGS=--check
check-format: format

.PHONY: typecheck-juvix-files
typecheck:
	@for file in $(JUVIXFILES); do \
		${JUVIXBIN} typecheck "$$file" $(JUVIXTYPECHECKFLAGS); \
		exit_code=$$?; \
		if [ $$exit_code -eq 0 ]; then \
			echo "[OK] $$file typechecks"; \
		else \
			echo "[FAIL] Typecking failed for $$file" && exit 1 ; \
		fi; \
	done

