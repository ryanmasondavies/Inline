//
//  INLReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLReporterTests : SenTestCase

@end

@implementation INLReporterTests

- (void)testForwardsEnterGroupToWritersInOrder
{
    // given
    id group = [OCMockObject mockForClass:[INLGroup class]];
    NSMutableArray *writers = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 5; i ++) {
        writers[i] = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
        [[[writers[i] stub] andDo:^(NSInvocation *invocation) { [order addObject:@(i)]; }] didEnterGroup:group];
    }
    INLReporter *reporter = [[INLReporter alloc] initWithWriters:writers];
    
    // when
    [reporter didEnterGroup:group];
    
    // then
    [[order should] beEqualTo:@[@0, @1, @2, @3, @4]];
}

- (void)testForwardsWillRunToWriters
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    NSMutableArray *writers = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 5; i ++) {
        writers[i] = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
        [[[writers[i] stub] andDo:^(NSInvocation *invocation) { [order addObject:@(i)]; }] willRunTest:test];
    }
    INLReporter *reporter = [[INLReporter alloc] initWithWriters:writers];
    
    // when
    [reporter willRunTest:test];
    
    // then
    [[order should] beEqualTo:@[@0, @1, @2, @3, @4]];
}

- (void)testForwardsDidRunToWriters
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    NSMutableArray *writers = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 5; i ++) {
        writers[i] = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
        [[[writers[i] stub] andDo:^(NSInvocation *invocation) { [order addObject:@(i)]; }] didRunTest:test];
    }
    INLReporter *reporter = [[INLReporter alloc] initWithWriters:writers];
    
    // when
    [reporter didRunTest:test];
    
    // then
    [[order should] beEqualTo:@[@0, @1, @2, @3, @4]];
}

- (void)testForwardsLeaveGroupToWriters
{
    // given
    id group = [OCMockObject mockForClass:[INLGroup class]];
    NSMutableArray *writers = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 5; i ++) {
        writers[i] = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
        [[[writers[i] stub] andDo:^(NSInvocation *invocation) { [order addObject:@(i)]; }] didLeaveGroup:group];
    }
    INLReporter *reporter = [[INLReporter alloc] initWithWriters:writers];
    
    // when
    [reporter didLeaveGroup:group];
    
    // then
    [[order should] beEqualTo:@[@0, @1, @2, @3, @4]];
}

@end
