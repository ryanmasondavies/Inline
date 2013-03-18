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
    // given
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    INLGroup *group = [[INLGroup alloc] init];
    
    // when
    [stack pushGroup:group];
    
    // then
    [[[groups lastObject] should] beIdenticalTo:group];
}

- (void)testPoppingReturnsTopFromArray
{
    // given
    INLGroup *group = [[INLGroup alloc] init];
    NSMutableArray *groups = [[NSMutableArray alloc] initWithObjects:group, nil];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    
    // when
    INLGroup *popped = [stack popGroup];
    
    // then
    [[@(popped == nil) shouldNot] beTrue];
    [[popped should] beIdenticalTo:group];
}

- (void)testPoppingRemovesTopFromArray
{
    // given
    INLGroup *group = [[INLGroup alloc] init];
    NSMutableArray *groups = [[NSMutableArray alloc] initWithObjects:group, nil];
    INLStack *stack = [[INLStack alloc] initWithGroups:groups];
    
    // when
    [stack popGroup];
    
    // then
    [[@([groups count]) should] beZero];
}

@end
