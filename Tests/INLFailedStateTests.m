//
//  INLFailedStateTests.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLFailedStateTests : SenTestCase

@end

@implementation INLFailedStateTests

- (void)testDescriptionReturnsLabelAndReason
{
    // given
    INLFailedState *state = [[INLFailedState alloc] initWithLabel:@"state" reason:@"failed"];
    
    // when
    NSString *description = [state description];
    
    // then
    [[description should] beEqualTo:@"state (failed)"];
}

@end
