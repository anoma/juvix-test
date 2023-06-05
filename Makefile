
all: test

deps/stdlib:
	@mkdir -p deps/
	@git clone https://github.com/anoma/juvix-stdlib.git deps/stdlib
	@git -C deps/stdlib checkout e94ea21027ffa63929ab67e12e917b23792b8c57

deps: deps/stdlib

build/Example: Example.juvix $(wildcard ./**/*.juvix) deps
	@mkdir -p build/
	juvix compile -o build/Example Example.juvix

.PHONY : test
test: build/Example
	./build/Example

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean
clean: clean-deps clean-build
