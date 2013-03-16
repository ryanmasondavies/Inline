//
//  INLTestTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestTests : SenTestCase
@property (strong, nonatomic) NSMutableArray *hooks;
@property (strong, nonatomic) NSMutableArray *groups;
@property (strong, nonatomic) NSMutableArray *order;
@property (strong, nonatomic) INLTest *test;
@end

@implementation INLTestTests

- (void)setUp
{
    self.hooks  = [NSMutableArray array];
    self.groups = [NSMutableArray array];
    self.order  = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        self.groups[i] = [[INLGroup alloc] init];
        if (i > 0) [self.groups[i-1] addNode:self.groups[i]];
        self.hooks[i] = [OCMockObject partialMockForObject:[[INLHook alloc] init]];
        [[[self.hooks[i] expect] andDo:^(NSInvocation *invocation) { [self.order addObject:self.hooks[i]]; }] execute];
        [self.groups[i] addNode:self.hooks[i]];
    }
    
    self.test = [[INLTest alloc] init];
    [[self.groups lastObject] addNode:self.test];
}

- (void)testStartsInPendingState
{
    [[@([self.test state]) should] beEqualTo:@(INLTestStatePending)];
}

- (void)testExecutesBeforeHooksInForwardOrder
{
    [[self hooks] enumerateObjectsUsingBlock:^(id hook, NSUInteger idx, BOOL *stop) {
        [hook setPlacement:INLHookPlacementBefore];
    }];
    
    [[self test] executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:[self test]] placement:INLHookPlacementBefore];
    
    [[@(self.hooks[0] == self.order[0]) should] beTrue];
    [[@(self.hooks[1] == self.order[1]) should] beTrue];
    [[@(self.hooks[2] == self.order[2]) should] beTrue];
}

- (void)testExecutesAfterHooksInOutwardOrder
{
    [[self hooks] enumerateObjectsUsingBlock:^(id hook, NSUInteger idx, BOOL *stop) {
        [hook setPlacement:INLHookPlacementAfter];
    }];
    
    [[self test] executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:[self test]] placement:INLHookPlacementAfter];
    
    [[@(self.hooks[0] == self.order[2]) should] beTrue];
    [[@(self.hooks[1] == self.order[1]) should] beTrue];
    [[@(self.hooks[2] == self.order[0]) should] beTrue];
}

- (void)testIgnoresHooksInSiblingGroups
{
    id sibling = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[sibling stub] andReturn:self.groups[1]] parent];
    id hook = [OCMockObject niceMockForClass:[INLHook class]];
    [[[hook stub] andReturn:sibling] parent];
    [[hook reject] execute];
    [self.test executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self.test] placement:INLHookPlacementBefore];
    [self.test executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self.test] placement:INLHookPlacementAfter];
    [hook verify];
}

- (void)testIgnoresHooksInDeeperNestedGroups
{
    id descendant = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[descendant stub] andReturn:self.groups[2]] parent];
    id hook = [OCMockObject niceMockForClass:[INLHook class]];
    [[[hook stub] andReturn:descendant] parent];
    [[hook reject] execute];
    [self.test executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self.test] placement:INLHookPlacementBefore];
    [self.test executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self.test] placement:INLHookPlacementAfter];
    [hook verify];
}

@end
