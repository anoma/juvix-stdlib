
all: test

build/Test: $(shell find ../ -name "*.juvix") $(wildcard deps/**/*.juvix) Test.juvix
	@mkdir -p build
	juvix compile native -o build/Test Test.juvix

.PHONY: test
test: build/Test
	od -An -N2 -t u2 /dev/urandom | xargs | ./build/Test

.PHONY: clean-deps
clean-deps:
	juvix clean

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean
clean: clean-deps clean-build
