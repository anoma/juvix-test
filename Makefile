all: test

build/Example: Example.juvix $(wildcard ./**/*.juvix)
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
