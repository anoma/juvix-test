all: test

build/TestFail: tests/TestFail.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile -o build/TestFail tests/TestFail.juvix

build/TestPass: tests/TestPass.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile -o build/TestPass tests/TestPass.juvix

build/Example: Example.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile -o build/Example Example.juvix

.PHONY : example
example: build/Example
	./build/Example

.PHONY : test
test: build/TestFail build/TestPass
	tests/check_output.sh "./build/TestPass" expect_success "OK,Suite passed"
	tests/check_output.sh "./build/TestFail" expect_fail "FAIL,OK,Suite failed"

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@rm -rf deps/

.PHONY: clean
clean: clean-deps clean-build
