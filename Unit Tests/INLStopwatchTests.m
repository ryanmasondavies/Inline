//
//  INLStopwatchTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLStopwatchTests : SenTestCase

@end

@implementation INLStopwatchTests

- (void)testRecordsTimeTakenBetweenStartAndStop
{
    // given
    id timeProvider = [OCMockObject niceMockForClass:[INLTimeProvider class]];
    INLStopwatch *stopwatch = [[INLStopwatch alloc] initWithTimeProvider:timeProvider];
    [[[timeProvider expect] andReturnValue:OCMOCK_VALUE((NSTimeInterval){25})] time];
    [[[timeProvider expect] andReturnValue:OCMOCK_VALUE((NSTimeInterval){50})] time];
    
    // when
    [stopwatch start];
    [stopwatch stop];
    
    // then
    [[@([stopwatch timeElapsed]) should] beEqualTo:@25];
}

@end
