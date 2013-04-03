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

- (void)testRunExecutesBlock
{
    // given
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    INLReadyState *state = [[INLReadyState alloc] initWithBlock:block label:nil];
    
    // when
    [state runForTest:nil];
    
    // then
    [[@(executed) should] beTrue];
}

- (void)testDescriptionReturnsLabel
{
    // given
    INLReadyState *state = [[INLReadyState alloc] initWithBlock:nil label:@"state"];
    
    // when
    NSString *description = [state description];
    
    // then
    [[description should] beEqualTo:@"state"];
}

@end
