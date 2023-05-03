
all: test

deps/quickcheck:
	@mkdir -p deps/
	@git clone --branch use-abs-stdlib https://github.com/anoma/juvix-quickcheck.git deps/quickcheck
	$(MAKE) -C deps/quickcheck deps

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
