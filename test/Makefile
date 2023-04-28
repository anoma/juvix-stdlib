
all: test

deps/quickcheck:
	@mkdir -p deps/
	@git clone https://github.com/anoma/juvix-quickcheck.git deps/quickcheck
	@git -C deps/quickcheck checkout 2a23d8ed14d171fecf95892da401ddd37f96d40a
	@mkdir -p deps/quickcheck/deps/stdlib
	@rsync -av ../* deps/quickcheck/deps/stdlib --exclude "test"

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
