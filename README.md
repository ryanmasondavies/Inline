Inline
======

Inline aims to make it easier to create testing frameworks which integrate with Xcode, allowing developers to test any way they want.

How does it work?
-----------------

Test cases subclass `INLSenTestCase` rather than `SenTestCase`, and return an array of tests:

```
@interface Tests : INLSenTestCase
@end

@implementation Tests

- (NSArray *)tests
{
    return @[[[INLTest alloc] initWithName:@"test" block:^{} delegate:nil]];
}

@end
```

Rather than running tests itself, Inline transparently ships them off to SenTestingKit. Test names are displayed in the log after being stripped of whitespace and punctuation (necessary to integrate with Xcode.)

Tests can be contextualized by assigning a delegate:

```
- (NSArray *)tests
{
    id<INLRunnable> beforeHook = [[INLHook alloc] initWithBlock:^{ /* Runs before the test */ }];
    id<INLRunnable> afterHook = [[INLHook alloc] initWithBlock:^{ /* Runs after the test */ }];
    id<INLTestDelegate> beforeFilter = [[INLBeforeFilter alloc] initWithRunnable:beforeHook];
    id<INLTestDelegate> afterFilter = [[INLAfterFilter alloc] initWithRunnable:afterHook];
    id<INLTestDelegate> context = [[INLContext alloc] initWithDelegates:@[beforeFilter, afterFilter]];
    return @[[[INLTest alloc] initWithName:@"test" block:^{ /* Runs in the middle */ } delegate:context]];
}
```

A context is a group of delegates, each filtered to run before or after a test. Any object conforming to `INLTestDelegate` can be used here, making extension trivial. Additionally, as contexts also conform to `INLTestDelegate`, they can be nested within each other.

How do I make expectations?
---------------------------

Inline supports the use of SenTestingKit assertions like `STAssertTrue(...)`, and any expectation framework which supports SenTestingKit:

1. [Posit][] - Define what _should_ happen using a should-based syntax akin to [RSpec][].
2. [Expecta][] - Specify what you _expect_ to happen.

[Posit]: http://github.com/rdavies/Specify
[Expecta]: http://github.com/petejkim/Expecta
[RSpec]: http://rspec.info

Testing frameworks built on Inline
----------------------------------

For an example of how to implement your own framework using Inline, take a look at [Specify][].

[Specify]: http://www.github.com/rdavies/Specify

Installation
============

Inline is installed via [CocoaPods](https://github.com/CocoaPods/CocoaPods) by adding `pod 'Inline', '~> 0.3.0'` to your Podfile.

License
=======

	Copyright (c) 2013 Ryan Davies

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
