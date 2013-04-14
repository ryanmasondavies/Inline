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

@interface INLTestTests : SenTestCase
@property (nonatomic) BOOL blockExecuted;
@property (strong, nonatomic) id testDelegate;
@property (strong, nonatomic) INLTest *test;
@end

@implementation INLTestTests

- (void)setUp
{
    INLVoidBlock block = ^{ [self setBlockExecuted:YES]; };
    [self setTestDelegate:[OCMockObject niceMockForProtocol:@protocol(INLTestDelegate)]];
    [self setTest:[[INLTest alloc] initWithName:@"" block:block delegate:[self testDelegate]]];
}

- (void)testNotifiesDelegateBeforeExecutingBlock
{
    // given
    [[[[self testDelegate] expect] andDo:^(NSInvocation *invocation) { [[@([self blockExecuted]) should] beFalse]; }] testWillRun:[self test]];
    
    // when
    [[self test] run];
    
    // then
    [[self testDelegate] verify];
}

- (void)testRunExecutesBlock
{
    // when
    [[self test] run];
    
    // then
    [[@([self blockExecuted]) should] beTrue];
}

- (void)testNotifiesDelegateAfterExecutingBlock
{
    // given
    [[[[self testDelegate] expect] andDo:^(NSInvocation *invocation) { [[@([self blockExecuted]) should] beTrue]; }] testDidRun:[self test]];
    
    // when
    [[self test] run];
    
    // then
    [[self testDelegate] verify];
}

@end
