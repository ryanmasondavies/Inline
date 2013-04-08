//
//  INLPendingStateTests.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLPendingStateTests : SenTestCase

@end

@implementation INLPendingStateTests

- (void)testNotifiesReporterThatTestIsSkipped
{
    // given
    INLPendingState *state = [[INLPendingState alloc] initWithName:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id reporter = [OCMockObject niceMockForProtocol:@protocol(INLReporter)];
    [[reporter expect] testDidSkip:test];
    [state runWithReporter:reporter forTest:test];
    
    // then
    [reporter verify];
}

@end
