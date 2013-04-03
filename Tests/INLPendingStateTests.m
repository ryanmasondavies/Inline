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

- (void)testDescriptionReturnsLabel
{
    // given
    INLPendingState *state = [[INLPendingState alloc] initWithLabel:@"state"];
    
    // when
    NSString *description = [state description];
    
    // then
    [[description should] beEqualTo:@"state"];
}

@end
