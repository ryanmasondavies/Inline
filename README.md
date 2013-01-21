Inline
======

Subclasses `SenTestCase` with `INLTestCase`, and adds the following methods:

    +addTestInvocation:
    +removeTestInvocation:

[OCUnit]() uses the `+testInvocations` method on `SenTestCase` to determine the tests available in that suite. The default implementation retrieves methods which return `void`, have no arguments, and are prefixed with `test`. This implementation is not easily extendable. Dynamically adding tests would require dynamically adding methods, which isn't practical, and restrains tests to the rules by which methods must abide. Calling `+testInvocations` on a subclass of `INLTestCase` results in all of the test invocations added to that subclass.

While the `SenTestCase` class manages all of the invocations in the suite, an instance manages only a single invocation. On `-setInvocation:`, however, it sets the invocation's target to the test case itself, because it is expecting to invoke a `test...` method on the subclass.

`INLTestCase` works around this by using instances of `INLTestInvocation`. `INLTestInvocation` implements the method `+invocationWithTest:`, a constructor meant for creating invocations with instances of `INLTest`. `INLTestInvocation` calls `-execute` on `INLTest`, which in turn executes its block.

INLTestCase` also overrides `-name`, the method which [OCUnit]()es to identify tests for printing to the console. The default implementation returns the method signature of the `test...` method, but `INLTestCase` returns the name of the current invocation's `INLTest` instance.

The following sample code adds a blank test named 'hello world' to a subclass of `INLTestCase`:

    #import <SenTestingKit/SenTestingKit.h>
    #import <Inline/Inline.h>
      
    @interface SomeTests : INLTestCase; @end
      
    @implementation SomeTests
      
    + (void)initialize
    {
        INLTest *test = [[INLTest alloc] init];
        [test setName:@"hello world"];
        [test setBlock:^{}];
        [self addTestInvocation:[INLTestInvocation invocationWithTest:test]];
    }
      
    @end

This test would result in something like the following output:

    Run test suite SomeTests
    Test Suite 'SomeTests' started at 2013-01-21 13:16:52 +0000
    Run test case hello world
    Test Case 'hello world' started.
    Test Case 'hello world' passed (0.000 seconds).
      
    Test Suite 'SomeTests' finished at 2013-01-21 13:16:52 +0000.
    Executed 1 test, with 0 failures (0 unexpected) in 0.000 (0.000) seconds

Installation
------------

Inline is installed via [CocoaPods](). Add `pod 'Inline'` to your Podfile and run `pod install`.

Documentation
-------------

Comments are written using the [Appledoc]() syntax, and documentation will be automatically generated and added to Xcode by [CocoaPods]() upon installation.

The files will also be made available elsewhere (see [#1](Inline/issues/1)).

License
-------

Copyright (c) 2012 Ryan Davies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

See the [LICENSE](Inline/blob/master/LICENSE) file.

[OCUnit]:    http://www.sente.ch/software/ocunit/
[CocoaPods]: https://github.com/CocoaPods/CocoaPods
[Appledoc]:  http://gentlebytes.com/appledoc/
