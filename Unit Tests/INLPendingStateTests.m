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

- (void)testNotifiesResponderThatTestIsSkipped
{
    // given
    INLPendingState *state = [[INLPendingState alloc] initWithName:nil];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLCompiler)];
    [[responder expect] testDidSkip:test];
    [state runWithResponder:responder forTest:test];
    
    // then
    [responder verify];
}

@end
