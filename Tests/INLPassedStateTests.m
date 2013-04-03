//
//  INLPassedStateTests.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLPassedStateTests : SenTestCase

@end

@implementation INLPassedStateTests

- (void)testDescriptionReturnsLabel
{
    // given
    INLPassedState *state = [[INLPassedState alloc] initWithLabel:@"state"];
    
    // when
    NSString *description = [state description];
    
    // then
    [[description should] beEqualTo:@"state"];
}

@end
