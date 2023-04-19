
all: test

deps/quickcheck:
	@mkdir -p deps/
	@git clone --branch main --depth 1 https://github.com/paulcadman/quickcheck.git deps/quickcheck

build/Test: Test.juvix deps/quickcheck
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
