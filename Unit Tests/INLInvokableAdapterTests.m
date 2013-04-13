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

@interface INLInvokableAdapterTests : SenTestCase
@property (nonatomic) BOOL invoked;
@property (strong, nonatomic) id invokable;
@property (strong, nonatomic) INLInvokableAdapter *adapter;
@end

@implementation INLInvokableAdapterTests

- (void)setUp
{
    [self setInvoked:NO];
    [self setInvoked:[OCMockObject niceMockForProtocol:@protocol(INLInvokable)]];
    [self setAdapter:[[INLInvokableAdapter alloc] initWithInvokable:[self invokable]]];
    [[[[self invokable] stub] andDo:^(NSInvocation *invocation) { [self setInvoked:YES]; }] invoke];
}

- (void)testWhenReceivesInvokeCallsInvokeOnInvokable
{
    // when
    [[self adapter] invoke];
    
    // then
    [[@(self.invoked) should] beTrue];
}

- (void)testWhenReceivesInvokeWithTargetCallsInvokeOnInvokable
{
    // when
    [[self adapter] invokeWithTarget:[NSObject new]];
    
    // then
    [[@(self.invoked) should] beTrue];
}

- (void)testRespondsToSetSelector
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] setSelector:@selector(description)]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testReturnsNilForSelector
{
    // when
    SEL selector = [[self adapter] selector];
    
    // then
    [[@(selector != nil) should] beFalse];
}

- (void)testRespondsToSetTarget
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] setTarget:[NSObject new]]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testReturnsNilForTarget
{
    // when
    id target = [[self adapter] target];
    
    // then
    [[@(target != nil) should] beFalse];
}

- (void)testRespondsToSetArgumentAtIndex
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] setArgument:NULL atIndex:0]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testRespondsToGetArgumentAtIndex
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] getArgument:NULL atIndex:0]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testReturnsNoForArgumentsRetained
{
    // when
    BOOL retainsArguments = [[self adapter] argumentsRetained];
    
    // then
    [[@(retainsArguments) should] beFalse];
}

- (void)testRespondsToRetainArguments
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] retainArguments]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testRespondsToSetReturnValue
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] setReturnValue:NULL]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testRespondsToGetReturnValue
{
    // when
    NSException *exception = nil;
    @try { [[self adapter] getReturnValue:NULL]; }
    @catch (NSException *e) { exception = e; }
    
    // then
    [[@(exception != nil) should] beFalse];
}

- (void)testReturnsNilForMethodSignature
{
    // when
    id target = [[self adapter] methodSignature];
    
    // then
    [[@(target != nil) should] beFalse];
}

@end
