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

- (void)testOnRunExecutesBlock
{
    // given
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    INLReadyState *state = [[INLReadyState alloc] initWithBlock:block];
    
    // when
    [state runForTest:nil];
    
    // then
    [[@(executed) should] beTrue];
}

@end
