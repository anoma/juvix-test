# A testing framework for Juvix

Obtain the Juvix compiler at https://github.com/anoma/juvix

## Example

The following module defines a simple test suite:

```
module Example;

import Stdlib.Prelude open;
import Test.JuvixUnit open;

tests : List Test :=
  [testCase "1 == 1" (assertEqual eqNatI "1 /= 1" 1 1)];

main : IO := runTestSuite (testSuite "Example" tests);
```

Compile and run the test suite:

``` shell
$ juvix compile Example.juvix
$ ./Example
Test suite 'Example'
1 == 1		OK
All tests from test suite 'Example' complete
```
