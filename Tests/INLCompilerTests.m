//
//  INLCompilerTests.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLCompilerTests : SenTestCase
@property (strong, nonatomic) INLCompiler *compiler;
@property (strong, nonatomic) NSMutableArray *tests;
@end

@implementation INLCompilerTests

- (void)setUp
{
    self.compiler = [[INLCompiler alloc] init];
    self.tests = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; i ++) self.tests[i] = [[INLTest alloc] init];
}

- (void)testCreatesInvocationsForTests
{
    INLGroup *group = [[INLGroup alloc] init];
    for (NSUInteger i = 0; i < 3; i ++) [group addNode:self.tests[i]];
    NSArray *invocations = [[self compiler] invocationsForGroup:group];
    for (NSUInteger i = 0; i < 3; i ++) [[[invocations[i] test] should] beIdenticalTo:self.tests[i]];
}

- (void)testMovesInvocationsForNestedTestsToEnd
{
    NSMutableArray *groups = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; i ++) groups[i] = [[INLGroup alloc] init];
    [groups[0] addNode:groups[1]];
    [groups[1] addNode:groups[2]];
    [groups[0] addNode:self.tests[0]];
    [groups[1] addNode:self.tests[1]];
    [groups[2] addNode:self.tests[2]];
    NSArray *invocations = [[self compiler] invocationsForGroup:groups[0]];
    for (NSUInteger i = 0; i < 3; i ++) [[[invocations[i] test] should] beIdenticalTo:self.tests[i]];
}

@end
