//
//  INLRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLRunnerTests : SenTestCase

@end

@implementation INLRunnerTests

- (void)testRunVisitsNode
{
    // given
    id node = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:nil];
    [[node expect] acceptVisitor:runner];
    
    // when
    [runner runByStartingAtNode:node];
    
    // then
    [node verify];
}

- (void)testNotifiesDelegateWhenEnteringGroup
{
    // given
    id group = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id delegate = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:delegate];
    [[delegate expect] didEnterGroup:group];
    
    // when
    [runner enterGroup:group];
    
    // then
    [delegate verify];
}

- (void)testNotifiesDelegateBeforeRunningTest
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    id delegate = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:delegate];
    __block BOOL executed = NO;
    [[[delegate expect] andDo:^(NSInvocation *inv) { executed = YES; }] willRunTest:test];
    [(INLTest *)[[test expect] andDo:^(NSInvocation *inv) { [delegate verify]; }] run];
    
    // when
    [runner visitTest:test];
    
    // then
    [[@(executed) should] beTrue];
    [delegate verify];
}

- (void)testRunsTests
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    INLRunner *runner = [[INLRunner alloc] init];
    [(INLTest *)[test expect] run];
    
    // when
    [runner visitTest:test];
    
    // then
    [test verify];
}

- (void)testNotifiesDelegateAfterRunningTest
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    id delegate = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:delegate];
    __block BOOL executed = NO;
    [(INLTest *)[[test expect] andDo:^(NSInvocation *inv) { executed = YES; }] run];
    [[[delegate expect] andDo:^(NSInvocation *inv) { [test verify]; }] didRunTest:test];
    
    // when
    [runner visitTest:test];
    
    // then
    [[@(executed) should] beTrue];
    [delegate verify];
}

- (void)testRunsHooks
{
    // given
    id hook = [OCMockObject mockForClass:[INLHook class]];
    INLRunner *runner = [[INLRunner alloc] init];
    [(INLHook *)[hook expect] run];
    
    // when
    [runner visitHook:hook];
    
    // then
    [hook verify];
}

- (void)testNotifiesDelegateWhenLeavingGroup
{
    // given
    id group = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id delegate = [OCMockObject niceMockForProtocol:@protocol(INLRunnerDelegate)];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:delegate];
    [[delegate expect] didLeaveGroup:group];
    
    // when
    [runner leaveGroup:group];
    
    // then
    [delegate verify];
}

@end
