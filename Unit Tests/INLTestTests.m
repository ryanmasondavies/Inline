//
//  INLTestTests.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestTests : SenTestCase
@end

@implementation INLTestTests

- (void)testInvokesBlock
{
    __block BOOL executed = NO;
    INLTest *test = [[INLTest alloc] init];
    [test setBlock:^{ executed = YES; }];
    [test execute];
    STAssertTrue(executed, @"");
}

@end
