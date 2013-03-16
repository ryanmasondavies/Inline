//
//  INLBlockHookTests.m
//  Inline
//
//  Created by Ryan Davies on 05/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLBlockHookTests : SenTestCase
@end

@implementation INLBlockHookTests

- (void)testInvokesTheAssignedBlock
{
    INLBlockHook *hook = [[INLBlockHook alloc] init];
    __block BOOL executed = NO;
    [hook setBlock:^{ executed = YES; }];
    [hook execute];
    STAssertTrue(executed, @"");
}

@end
