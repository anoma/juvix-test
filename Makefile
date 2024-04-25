all: test

build/TestFail: tests/TestFail.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile native -o build/TestFail tests/TestFail.juvix

build/TestPass: tests/TestPass.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile native -o build/TestPass tests/TestPass.juvix

build/Example: Example.juvix $(wildcard ./**/*.juvix)
	@mkdir -p build/
	juvix compile native -o build/Example Example.juvix

.PHONY : example
example: build/Example
	./build/Example

.PHONY : test
test: build/TestFail build/TestPass build/Example
	tests/check_output.sh "./build/TestPass" expect_success "OK,Suite passed"
	tests/check_output.sh "./build/TestFail" expect_fail "FAIL,OK,Suite failed"
	tests/check_output.sh "./build/Example" expect_success "OK,Suite passed"

.PHONY: clean-build
clean-build:
	@rm -rf build/

.PHONY: clean-deps
clean-deps:
	@juvix clean
	@(cd tests && exec juvix clean)

.PHONY: clean
clean: clean-deps clean-build
