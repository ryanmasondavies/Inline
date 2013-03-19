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

- (void)testForwardsVisitsToEachNode
{
    // given
    id<INLVisitor> visitor = [OCMockObject mockForProtocol:@protocol(INLVisitor)];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nodes weight:nil];
    for (NSUInteger i = 0; i < 3; i ++) {
        nodes[i] = [OCMockObject mockForProtocol:@protocol(INLNode)];
        [[nodes[i] expect] acceptVisitor:visitor];
    }
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [nodes makeObjectsPerformSelector:@selector(verify)];
}

- (void)testAddsNodesToArray
{
    // given
    id<INLNode> node = [OCMockObject mockForProtocol:@protocol(INLNode)];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nodes weight:nil];
    
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
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nodes weight:nil];
    
    // when
    [group removeNode:node];
    
    // then
    [[@([nodes count]) should] beEqualTo:@0];
}

- (void)testUsesLabelAsDescription
{
    // given
    INLGroup *group = [[INLGroup alloc] initWithLabel:@"Group" nodes:nil weight:nil];
    
    // then
    [[[group description] should] beEqualTo:@"Group"];
}

@end
