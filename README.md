Inline
======

Inline provides convenient methods by which to build and compile tests in the context of the domain. These two behaviours - building and compiling tests - are the two features which a DSL will need to make use of in order to implement its API.

A builder is responsible for the management of tests, for instance the builder in [Specify](http://github.com/rdavies/Specify), implements methods such as `addExample:`.

SenTestCase provides the following:

    +(id<INLTestBuilder>)builder
    +(id<INLTestCompiler>)compiler
    
A builder is an instance which abides by the INLTestBuilder protocol, which specifies an interface to which test builders must conform:

    -(NSArray *)tests
    
That's it. A method which returns an array of objects which conform to INLTest:

    -(void)execute

[OCUnit](http://www.sente.ch/software/ocunit/) uses the `+testInvocations` method on SenTestCase to determine the tests available in that suite. The default implementation retrieves methods which return `void`, have no arguments, and are prefixed with 'test'. This implementation is not easily extendable. Dynamically adding tests would require dynamically adding methods, which isn't practical, and restrains tests to the rules by which methods must abide.

Calling `+testInvocations` on a subclass of INLTestCase results in a call to `+testInvocationsForTests:` on the compiler, which has the builder's tests passed to it. The compiler is then responsible for compiling a list of invocations from the tests added to the builder.

While the SenTestCase class manages all of the invocations in the suite, an instance manages only a single invocation. On `-setInvocation:`, however, it sets the invocation's target to the test case itself, because it is expecting to invoke a 'test...' method on the subclass.

INLTestCase works around this by using instances of INLTestInvocation. INLTestInvocation implements the method `+invocationWithTest:`, a constructor meant for creating invocations with instances of INLTest. INLTestInvocation calls `-execute` on INLTest, which in turn executes its block.

INLTestCase also overrides `-name`, the method which [OCUnit](http://www.sente.ch/software/ocunit/) uses to describe tests for printing to the console. The default implementation returns the method signature of the `test...` method, but INLTestCase returns the description of the current invocation's test (`-description`).

Installation
------------

Inline is installed via [CocoaPods](https://github.com/CocoaPods/CocoaPods). Add `pod 'Inline'` to your Podfile and run `pod install`.

Documentation
-------------

Comments are written using the [Appledoc](http://gentlebytes.com/appledoc/) syntax, and documentation will be automatically generated and added to Xcode by [CocoaPods](https://github.com/CocoaPods/CocoaPods) upon installation.

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
