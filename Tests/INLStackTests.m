//
//  INLStackTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLStackTests : SenTestCase

@end

@implementation INLStackTests

- (void)testPushingAddsItToArray
{
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    INLGroup *group = [[INLGroup alloc] init];
    [stack pushGroup:group];
    [[[groups lastObject] should] beIdenticalTo:group];
}

- (void)testPoppingReturnsTopFromArray
{
    INLGroup *group = [[INLGroup alloc] init];
    NSMutableArray *groups = [[NSMutableArray alloc] initWithObjects:group, nil];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    INLGroup *popped = [stack popGroup];
    [[@(popped == nil) shouldNot] beTrue];
    [[popped should] beIdenticalTo:group];
}

- (void)testPoppingRemovesTopFromArray
{
    INLGroup *group = [[INLGroup alloc] init];
    NSMutableArray *groups = [[NSMutableArray alloc] initWithObjects:group, nil];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    [stack popGroup];
    [[@([groups count]) should] beZero];
}

@end
