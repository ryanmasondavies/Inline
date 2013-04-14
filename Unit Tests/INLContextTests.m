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

@interface INLContextTests : SenTestCase
@property (strong, nonatomic) id test;
@property (strong, nonatomic) NSMutableArray *contextDelegates;
@property (strong, nonatomic) INLContext *context;
@end

@implementation INLContextTests

- (void)setUp
{
    [self setTest:[OCMockObject niceMockForClass:[INLTest class]]];
    [self setContextDelegates:[[NSMutableArray alloc] init]];
    [self setContext:[[INLContext alloc] initWithDelegates:[self contextDelegates]]];
    
    for (NSUInteger i = 0; i < 10; i ++) {
        [[self contextDelegates] addObject:[OCMockObject niceMockForProtocol:@protocol(INLTestDelegate)]];
    }
}

- (void)testForwardsTestWillRunToDelegates
{
    // given
    [[self contextDelegates] enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL *stop) {
        [[delegate expect] testWillRun:[self test]];
    }];
    
    // when
    [[self context] testWillRun:[self test]];
    
    // then
    [[self contextDelegates] makeObjectsPerformSelector:@selector(verify)];
}

- (void)testForwardsTestDidRunToDelegates
{
    // given
    [[self contextDelegates] enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL *stop) {
        [[delegate expect] testDidRun:[self test]];
    }];
    
    // when
    [[self context] testDidRun:[self test]];
    
    // then
    [[self contextDelegates] makeObjectsPerformSelector:@selector(verify)];
}

@end
