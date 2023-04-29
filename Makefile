
all: test

deps/traits:
	@mkdir -p deps/
	@git clone --branch v0.1.0 --depth 1 https://github.com/paulcadman/traits.git deps/traits

deps: deps/traits

.PHONY : test
test: deps

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean
clean: clean-deps clean-build
