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

- (void)testTellsVisitorToVisitTest
{
    // given
    INLTest *test = [[INLTest alloc] initWithState:nil weight:nil];
    id visitor = [OCMockObject mockForProtocol:@protocol(INLVisitor)];
    [[visitor expect] visitTest:test];
    
    // when
    [test acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

- (void)testForwardsRunningToState
{
    // given
    id state = [OCMockObject mockForProtocol:@protocol(INLTestState)];
    INLTest *test = [[INLTest alloc] initWithState:state weight:nil];
    [[state expect] runForTest:test];
    
    // when
    [test run];
    
    // then
    [state verify];
}

- (void)testChangingStateForwardsRunningToNewState
{
    // given
    INLTest *test = [[INLTest alloc] initWithState:nil weight:nil];
    id state = [OCMockObject mockForProtocol:@protocol(INLTestState)];
    [[state expect] runForTest:test];
    
    // when
    [test transitionToState:state];
    [test run];
    
    // then
    [state verify];
}

- (void)testReturnsLabelOfState
{
    // given
    id state = [OCMockObject niceMockForProtocol:@protocol(INLTestState)];
    INLTest *test = [[INLTest alloc] initWithState:state weight:nil];
    [[[state stub] andReturn:@"some label"] label];
    
    // when
    NSString *label = [test label];
    
    // then
    [[label should] beEqualTo:@"some label"];
}

@end
