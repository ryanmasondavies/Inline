// The MIT License
//
// Copyright (c) 2013 Ryan Davies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

static BOOL firstTestRan;
static BOOL secondTestRan;

@interface INLTwoPassingTests : INLSenTestCase

@end

@implementation INLTwoPassingTests

- (INLGroup *)tests
{
    INLBlockInvoker *robotInvoker = [[INLBlockInvoker alloc] initWithBlock:^{ firstTestRan = YES; }];
    INLTest *robotTest = [[INLTest alloc] initWithName:@"the mighty robot test" invokable:robotInvoker weight:@1];
    
    INLBlockInvoker *titanInvoker = [[INLBlockInvoker alloc] initWithBlock:^{ secondTestRan = YES; }];
    INLTest *titanTest = [[INLTest alloc] initWithName:@"the mighty titan test" invokable:titanInvoker weight:@2];
    
    NSSortDescriptor *lightestToHeaviest = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:@[robotTest, titanTest] sortDescriptors:@[lightestToHeaviest]];
    return [[INLGroup alloc] initWithName:@"" components:sorted weight:@0];
}

@end

@interface INLTwoPassingTestsTests : SenTestCase

@end

@implementation INLTwoPassingTestsTests

- (void)testTwoTestsAreRun
{
    firstTestRan = secondTestRan = NO;
    [INLTestCaseRunner runTestsForClass:[INLTwoPassingTests class]];
    [[@(firstTestRan) should] beTrue];
    [[@(secondTestRan) should] beTrue];
}

@end
