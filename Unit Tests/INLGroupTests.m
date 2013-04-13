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

@interface INLGroupTests : SenTestCase

@end

@implementation INLGroupTests

- (void)testTellsCompilerItWillCompileGroupBeforeForwarding
{
    // given
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id compiler = [OCMockObject niceMockForProtocol:@protocol(INLCompiler)];
    __block BOOL forwardedCompiler = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedCompiler = YES; }] compileWithCompiler:compiler];
    [[[compiler expect] andDo:^(NSInvocation *i) { [[@(forwardedCompiler) should] beFalse]; }] willCompileGroup:group];
    
    // when
    [group compileWithCompiler:compiler];
    
    // then
    [compiler verify];
}

- (void)testForwardsRunToEachComponent
{
    // given
    id compiler = [OCMockObject niceMockForProtocol:@protocol(INLCompiler)];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id component = [OCMockObject mockForProtocol:@protocol(INLComponent)];
        [[[component stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] compileWithCompiler:compiler];
        [components addObject:component];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:components sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:sorted weight:nil];
    
    // when
    [group compileWithCompiler:compiler];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testNotifiesReporterThatGroupHasFinishedAfterForwardingRunToComponents
{
    // given
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id compiler = [OCMockObject niceMockForProtocol:@protocol(INLCompiler)];
    __block BOOL forwardedCompiler = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedCompiler = YES; }] compileWithCompiler:compiler];
    [[[compiler expect] andDo:^(NSInvocation *i) { [[@(forwardedCompiler) should] beTrue]; }] didCompileGroup:group];
    
    // when
    [group compileWithCompiler:compiler];
    
    // then
    [compiler verify];
}

@end
