
all: test

deps/quickcheck:
	@mkdir -p deps/
	@git clone --branch v0.2.0 --depth 1 https://github.com/anoma/juvix-quickcheck.git deps/quickcheck

build/Test: $(shell find ../ -name "*.juvix") $(wildcard deps/**/*.juvix) Test.juvix deps/quickcheck
	@mkdir -p build
	juvix compile -o build/Test Test.juvix

.PHONY: test
test: build/Test
	od -An -N2 -t u2 /dev/urandom | xargs | ./build/Test

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean
clean: clean-deps clean-build
