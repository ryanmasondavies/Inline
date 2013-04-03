//
//  INLGroupTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupTests : SenTestCase

@end

@implementation INLGroupTests

- (void)testTellsVisitorToVisitGroup
{
    // todo: verify order
    
    // given
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nil weight:nil];
    id visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    [[visitor expect] enterGroup:group];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

- (void)testForwardsVisitsToEachNode
{
    // todo: verify order
    
    // given
    id<INLVisitor> visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id node = [OCMockObject mockForProtocol:@protocol(INLNode)];
        [[[node stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] acceptVisitor:visitor];
        [nodes addObject:node];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:sorted weight:nil];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testTellsVisitorToLeaveGroup
{
    // todo: verify order
    
    // given
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nil weight:nil];
    id visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    [[visitor expect] leaveGroup:group];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

- (void)testAddsNodesToArray
{
    // given
    id<INLNode> node = [OCMockObject mockForProtocol:@protocol(INLNode)];
    NSMutableArray *nodes = [[NSMutableArray alloc] initWithArray:@[node]];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:sorted weight:nil];
    
    // when
    [group addNode:node];
    
    // then
    [[@([nodes objectAtIndex:0] == node) should] beTrue];
}

- (void)testRemovesNodesFromArray
{
    // given
    id<INLNode> node = [OCMockObject mockForProtocol:@protocol(INLNode)];
    NSMutableArray *nodes = [[NSMutableArray alloc] initWithObjects:node, nil];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:sorted weight:nil];
    
    // when
    [group removeNode:node];
    
    // then
    [[@([sorted count]) should] beEqualTo:@0];
}

- (void)testUsesLabelAsDescription
{
    // given
    INLGroup *group = [[INLGroup alloc] initWithLabel:@"Group" nodes:nil weight:nil];
    
    // then
    [[[group description] should] beEqualTo:@"Group"];
}

@end
