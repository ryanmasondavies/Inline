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

static NSMutableArray *order;

@interface INLHooks : INLSenTestCase

@end

@implementation INLHooks

- (NSArray *)tests
{
    id<INLRunnable> beforeHook = [[INLHook alloc] initWithBlock:^{ [order addObject:@1]; }];
    id<INLRunnable> afterHook = [[INLHook alloc] initWithBlock:^{ [order addObject:@3]; }];
    id<INLTestDelegate> beforeFilter = [[INLBeforeFilter alloc] initWithRunnable:beforeHook];
    id<INLTestDelegate> afterFilter = [[INLAfterFilter alloc] initWithRunnable:afterHook];
    id<INLTestDelegate> context = [[INLContext alloc] initWithDelegates:@[afterFilter, beforeFilter]];
    
    return @[[[INLTest alloc] initWithName:@"test" block:^{ [order addObject:@2]; } delegate:context]];
}

@end

@interface INLHooksTests : SenTestCase

@end

@implementation INLHooksTests

- (void)testBothHooksAndTestAreRun
{
    order = [[NSMutableArray alloc] init];
    [INLTestCaseRunner runTestsForClass:[INLHooks class]];
    [[order should] beEqualTo:@[@1, @2, @3]];
}

@end
