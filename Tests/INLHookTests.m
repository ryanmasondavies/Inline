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

- (void)testExecutesBlock
{
    __block BOOL executed = NO;
    INLHookBlock block = ^{ executed = YES; };
    INLHook *hook = [[INLHook alloc] initWithBlock:block placement:0];
    [hook execute];
    [[@(executed) should] beTrue];
}

@end
