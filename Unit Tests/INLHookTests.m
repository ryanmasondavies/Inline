//
//  INLHookTests.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLHookTests : SenTestCase

@end

@implementation INLHookTests

- (void)testRunExecutesBlock
{
    // given
    __block BOOL executed = NO;
    INLHookBlock block = ^{ executed = YES; };
    INLHook *hook = [[INLHook alloc] initWithBlock:block weight:nil];
    
    // when
    [hook runWithReporter:nil];
    
    // then
    [[@(executed) should] beTrue];
}

@end
