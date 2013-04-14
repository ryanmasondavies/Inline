Inline
======

Inline aims to make it easier to create testing frameworks which integrate with Xcode, allowing developers to test any way they want.

It presents a powerful and extendable structure using a block based approach to running tests. It provides a means to easily nest tests within groups, as well as nesting other groups within groups.

Use it as you would SenTestingKit. When a test fails, you get a red flag. Pretty standard, but very important.

For an example of how to implement a framework using Inline, I suggest looking at [Specify][].

[Specify]: http://www.github.com/rdavies/Specify

Installation
============

Inline is installed via [CocoaPods](https://github.com/CocoaPods/CocoaPods) by adding `pod 'Inline', '~> 0.3.0'` to your Podfile.

Documentation
=============

Comments are written using the [Appledoc](http://gentlebytes.com/appledoc/) syntax, and documentation will be automatically generated and added to Xcode by [CocoaPods](https://github.com/CocoaPods/CocoaPods) upon installation.

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
