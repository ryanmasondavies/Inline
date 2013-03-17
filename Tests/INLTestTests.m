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

- (void)testUsesLabelAsDescription
{
    NSString *label = @"Test";
    INLTest *test = [[INLTest alloc] initWithLabel:label block:nil];
    [[[test description] should] beEqualTo:label];
}

- (void)testExecutesBlock
{
    __block BOOL executed = NO;
    INLTestBlock block = ^{ executed = YES; };
    INLTest *test = [[INLTest alloc] initWithLabel:nil block:block];
    [test execute];
    [[@(executed) should] beTrue];
}

- (void)testTellsVisitorToVisitTest
{
    // given
    INLTest *test = [[INLTest alloc] initWithLabel:nil block:nil];
    id visitor = [OCMockObject mockForProtocol:@protocol(INLVisitor)];
    [[visitor expect] visitTest:test];
    
    // when
    [test acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

@end
