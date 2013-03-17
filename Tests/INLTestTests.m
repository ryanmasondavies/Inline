//
//  INLTestTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestTests : SenTestCase
@end

@implementation INLTestTests

- (void)testExecutesBlock
{
    NSString *label = @"Test";
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    INLTest *test = [[INLTest alloc] initWithLabel:label block:block];
    [test execute];
    [[@(executed) should] beTrue];
}

@end
