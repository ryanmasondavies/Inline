//
//  INLNodePathTests.m
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNodePathTests : SenTestCase
@property (strong, nonatomic) NSMutableArray *groups;
@property (strong, nonatomic) INLNode *node;
@property (strong, nonatomic) INLNodePath *nodePath;
@end

@implementation INLNodePathTests

- (void)setUp
{
    self.groups = [NSMutableArray arrayWithObject:[INLGroup new]];
    self.node   = [[INLNode alloc] init];
    
    for (NSUInteger i = 1; i < 10; i ++) {
        self.groups[i] = [[INLGroup alloc] init];
        [self.groups[i-1] addNode:self.groups[i]];
    }
    
    [[[self groups] lastObject] addNode:[self node]];
    self.nodePath = [INLNodePath nodePathForDestinationNode:[self node]];
}

- (void)testGeneratesPathOfNodesLeadingToGivenNode
{
    [[@([[[self nodePath] nodes] count]) should] beEqualTo:@([[self groups] count])];
     
    [[self groups] enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger idx, BOOL *stop) {
        [[[[self nodePath] nodes][idx] should] beIdenticalTo:group];
    }];
}

- (void)testStoresDestinationNodeForReference
{
    [[[[self nodePath] destinationNode] should] beIdenticalTo:[self node]];
}

@end
