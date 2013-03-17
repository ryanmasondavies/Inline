//
//  INLGroupTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupTests : SenTestCase
@property (strong, nonatomic) INLGroup *group;
@property (strong, nonatomic) INLGroup *child;
@property (strong, nonatomic) INLTest  *test;
@property (strong, nonatomic) INLHook  *hook;
@end

@implementation INLGroupTests

- (void)setUp
{
    self.group = [[INLGroup alloc] init];
    self.child = [[INLGroup alloc] init];
    self.test  = [[INLTest  alloc] init];
    self.hook  = [[INLHook  alloc] init];
}

- (void)test_WhenGroupIsAdded_AddsItToGroups
{
    [[self group] addNode:[self child]];
    [[[[self group] groups][0] should] beIdenticalTo:[self child]];
}

- (void)test_WhenTestIsAdded_AddsItToTests
{
    [[self group] addNode:[self test]];
    [[[[self group] tests][0] should] beIdenticalTo:[self test]];
}

- (void)test_WhenHookIsAdded_AddsItToHooks
{
    [[self group] addNode:[self hook]];
    [[[[self group] hooks][0] should] beIdenticalTo:[self hook]];
}

- (void)test_WhenGroupIsRemoved_RemovesItFromGroups
{
    [[self group] addNode:[self child]];
    [[self group] removeNode:[self child]];
    
    BOOL result = [[[self group] groups] containsObject:[self child]];
    [[@(result) shouldNot] beTrue];
}

- (void)test_WhenTestIsRemoved_RemovesItFromTests
{
    [[self group] addNode:[self test]];
    [[self group] removeNode:[self test]];
    
    BOOL result = [[[self group] tests] containsObject:[self test]];
    [[@(result) shouldNot] beTrue];
}

- (void)test_WhenHookIsRemoved_RemovesItFromHooks
{
    [[self group] addNode:[self hook]];
    [[self group] removeNode:[self hook]];
    
    BOOL result = [[[self group] hooks] containsObject:[self hook]];
    [[@(result) shouldNot] beTrue];
}

@end
