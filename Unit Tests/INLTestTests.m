//
//  INLTestTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestTests : SenTestCase
@end

@implementation INLTestTests

- (void)testForwardsRunToState
{
    // given
    id state = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    id reporter = [OCMockObject niceMockForProtocol:@protocol(INLReporter)];
    INLTest *test = [[INLTest alloc] initWithState:state weight:nil];
    [[state expect] runWithReporter:reporter forTest:test];
    
    // when
    [test runWithReporter:reporter];
    
    // then
    [state verify];
}

- (void)testChangingStateForwardsRunToNewState
{
    // given
    INLTest *test = [[INLTest alloc] initWithState:nil weight:nil];
    id state = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    id reporter = [OCMockObject niceMockForProtocol:@protocol(INLReporter)];
    [[state expect] runWithReporter:reporter forTest:test];
    
    // when
    [test transitionToState:state];
    [test runWithReporter:reporter];
    
    // then
    [state verify];
}

- (void)testReturnsNameOfState
{
    // given
    id state = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTest *test = [[INLTest alloc] initWithState:state weight:nil];
    [[[state stub] andReturn:@"some name"] name];
    
    // when
    NSString *name = [test name];
    
    // then
    [[name should] beEqualTo:@"some name"];
}

@end
