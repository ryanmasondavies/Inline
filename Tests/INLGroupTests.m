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

- (void)testAddsNodesToArray
{
    id<INLNode> node = [OCMockObject mockForProtocol:@protocol(INLNode)];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nodes];
    [group addNode:node];
    [[@([nodes objectAtIndex:0] == node) should] beTrue];
}

- (void)testRemovesNodesFromArray
{
    id<INLNode> node = [OCMockObject mockForProtocol:@protocol(INLNode)];
    NSMutableArray *nodes = [[NSMutableArray alloc] initWithObjects:node, nil];
    INLGroup *group = [[INLGroup alloc] initWithLabel:nil nodes:nodes];
    [group removeNode:node];
    [[@([nodes count]) should] beEqualTo:@0];
}

- (void)testUsesLabelAsDescription
{
    INLGroup *group = [[INLGroup alloc] initWithLabel:@"Group" nodes:nil];
    [[[group description] should] beEqualTo:@"Group"];
}

@end
