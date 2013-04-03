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

- (void)testDescriptionReturnsLabel
{
    // given
    INLReadyState *state = [[INLReadyState alloc] initWithLabel:@"state" block:nil passedState:nil failedState:nil];
    
    // when
    NSString *description = [state description];
    
    // then
    [[description should] beEqualTo:@"state"];
}

- (void)testIfBlockDoesNotRaiseAnExceptionTransitionsToPassedState
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id passedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLReadyState *state = [[INLReadyState alloc] initWithLabel:nil block:^{} passedState:passedState failedState:nil];
    [[test expect] transitionToState:passedState];
    
    // when
    [state runForTest:test];
    
    // then
    [test verify];
}

- (void)testIfBlockRaisesAnExceptionTransitionsToFailedState
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id failedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTestBlock block = ^{ [NSException raise:@"Exception" format:nil]; };
    INLReadyState *state = [[INLReadyState alloc] initWithLabel:nil block:block passedState:nil failedState:failedState];
    [[test expect] transitionToState:failedState];
    
    // when
    [state runForTest:test];
    
    // then
    [test verify];
}


- (void)testIfBlockRaisesAnExceptionSetsReasonForFailedState
{
    // given
    id failedState = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTestBlock block = ^{ [NSException raise:@"Exception" format:@"some reason"]; };
    INLReadyState *state = [[INLReadyState alloc] initWithLabel:nil block:block passedState:nil failedState:failedState];
    [[failedState expect] setReason:@"some reason"];
    
    // when
    [state runForTest:nil];
    
    // then
    [failedState verify];
}


@end
