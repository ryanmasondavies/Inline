//
//  INLReadyStateTests.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLReadyStateTests : SenTestCase

@end

@implementation INLReadyStateTests

- (void)testStartsStopwatchBeforeExecutingBlock
{
    // given
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block stopwatch:stopwatch passedState:nil failedState:nil];
    
    // when
    [[[stopwatch expect] andDo:^(NSInvocation *invocation) {
        [[@(executed) should] beFalse];
    }] start];
    [state runWithReporter:nil forTest:nil];
    
    // then
    [stopwatch verify];
}

- (void)testStopsStopwatchAfterExecutingBlock
{
    // given
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block stopwatch:stopwatch passedState:nil failedState:nil];
    
    // when
    [[[stopwatch expect] andDo:^(NSInvocation *invocation) {
        [[@(executed) should] beTrue];
    }] stop];
    [state runWithReporter:nil forTest:nil];
    
    // then
    [stopwatch verify];
}

- (void)testIfBlockDoesNotRaiseAnExceptionNotifiesReporterThatTestPassed
{
    // given
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:^{} stopwatch:nil passedState:nil failedState:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    [[reporter expect] testDidPass:test withDuration:0];
    [state runWithReporter:reporter forTest:test];
    
    // then
    [reporter verify];
}

- (void)testIfBlockDoesNotRaiseAnExceptionHandsStopwatchTimeElapsedToReporter
{
    // given
    id stopwatch = [OCMockObject niceMockForClass:[INLStopwatch class]];
    [[[stopwatch stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){ 5.0 })] timeElapsed];
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:^{} stopwatch:stopwatch passedState:nil failedState:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    [[reporter expect] testDidPass:test withDuration:5.0];
    [state runWithReporter:reporter forTest:test];
    
    // then
    [reporter verify];
}

- (void)testIfBlockDoesNotRaiseAnExceptionTransitionsToPassedState
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id passedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:^{} stopwatch:nil passedState:passedState failedState:nil];
    [[test expect] transitionToState:passedState];
    
    // when
    [state runWithReporter:nil forTest:test];
    
    // then
    [test verify];
}

- (void)testIfBlockRaisesAnExceptionNotifiesReporterThatTestFailed
{
    // given
    NSException *exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"" userInfo:nil];
    INLTestBlock block = ^{ [exception raise]; };
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block stopwatch:nil passedState:nil failedState:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    [[reporter expect] testDidFail:test withException:exception];
    [state runWithReporter:reporter forTest:test];
    
    // then
    [reporter verify];
}

- (void)testIfBlockRaisesAnExceptionTransitionsToFailedState
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id failedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTestBlock block = ^{ [NSException raise:@"Exception" format:nil]; };
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block stopwatch:nil passedState:nil failedState:failedState];
    [[test expect] transitionToState:failedState];
    
    // when
    [state runWithReporter:nil forTest:test];
    
    // then
    [test verify];
}

@end
