//
//  INLRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLRunnerTests : SenTestCase

@end

@implementation INLRunnerTests

- (void)testNotifiesResponderThatRunHasStartedBeforeForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:nil];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithResponder:OCMOCK_ANY];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beFalse]; }] runDidStart];
    [runner runComponent:component withResponder:responder];
    
    // then
    [responder verify];
}

- (void)testStartsStopwatchForwardingRunToComponent
{
    // given
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:stopwatch];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    __block BOOL executed = NO;
    [[[component stub] andDo:^(NSInvocation *invocation) { executed = YES; }] runWithResponder:nil];
    [(INLStopwatch *)[[stopwatch expect] andDo:^(NSInvocation *invocation) { [[@(executed) should] beFalse]; }] start];
    [runner runComponent:component withResponder:nil];
    
    // then
    [stopwatch verify];
}

- (void)testForwardsRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:nil];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    [[component expect] runWithResponder:OCMOCK_ANY];
    [runner runComponent:component withResponder:nil];
    
    // then
    [component verify];
}

- (void)testPassesResponderToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:nil];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    [[component expect] runWithResponder:responder];
    [runner runComponent:component withResponder:responder];
    
    // then
    [component verify];
}

- (void)testStopsStopwatchAfterForwardingRunToComponent
{
    // given
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:stopwatch];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    __block BOOL executed = NO;
    [[[component stub] andDo:^(NSInvocation *invocation) { executed = YES; }] runWithResponder:nil];
    [(INLStopwatch *)[[stopwatch expect] andDo:^(NSInvocation *invocation) { [[@(executed) should] beTrue]; }] stop];
    [runner runComponent:component withResponder:nil];
    
    // then
    [stopwatch verify];
}

- (void)testNotifiesResponderThatRunHasFinishedAfterForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:nil];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithResponder:OCMOCK_ANY];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beTrue]; }] runDidFinishWithDuration:0];
    [runner runComponent:component withResponder:responder];
    
    // then
    [responder verify];
}

- (void)testInformsResponderOfHowLongRunTookAfterForwardingRunToComponent
{
    // given
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    [[[stopwatch stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){10})] timeElapsed];
    INLRunner *runner = [[INLRunner alloc] initWithStopwatch:stopwatch];
    
    // when
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    [[responder expect] runDidFinishWithDuration:10];
    [runner runComponent:nil withResponder:responder];
    
    // then
    [responder verify];
}

@end
