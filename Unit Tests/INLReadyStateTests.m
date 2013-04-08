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

- (void)testIfBlockDoesNotRaiseAnExceptionNotifiesReporterThatTestPassed
{
    // given
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:^{} passedState:nil failedState:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForProtocol:@protocol(INLReporter)];
    [[reporter expect] testDidPass:test];
    [state runWithReporter:reporter forTest:test];
    
    // then
    [reporter verify];
}

- (void)testIfBlockDoesNotRaiseAnExceptionTransitionsToPassedState
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id passedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:^{} passedState:passedState failedState:nil];
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
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block passedState:nil failedState:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForProtocol:@protocol(INLReporter)];
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
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block passedState:nil failedState:failedState];
    [[test expect] transitionToState:failedState];
    
    // when
    [state runWithReporter:nil forTest:test];
    
    // then
    [test verify];
}

- (void)testIfBlockRaisesAnExceptionSetsReasonForFailedState
{
    // given
    id failedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTestBlock block = ^{ [NSException raise:@"Exception" format:@"some reason"]; };
    INLReadyState *state = [[INLReadyState alloc] initWithName:nil block:block passedState:nil failedState:failedState];
    [[failedState expect] setReason:@"some reason"];
    
    // when
    [state runWithReporter:nil forTest:nil];
    
    // then
    [failedState verify];
}

@end
