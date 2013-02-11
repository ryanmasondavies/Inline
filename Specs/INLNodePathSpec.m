//
//  INLNodePathSpec.m
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLNodePath)

describe(@"initialization with a destination node", ^{
    __block NSMutableArray *groups;
    __block INLNode        *node;
    __block INLNodePath    *nodePath;
    
    before(^{
        groups = [NSMutableArray arrayWithObject:[INLGroup new]];
        node   = [[INLNode alloc] init];
        
        for (NSUInteger i = 1; i < 10; i ++) {
            groups[i] = [[INLGroup alloc] init];
            [groups[i-1] addNode:groups[i]];
        }
        
        [[groups lastObject] addNode:node];
    });
    
    void (^itBehavesLikeItPointsToDestinationNode)(void) = ^(void) {
        it(@"generates a path of nodes which lead to the given node", ^{
            expect([nodePath nodes]).to.haveCountOf([groups count]);
            [groups enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger idx, BOOL *stop) {
                expect([nodePath nodes][idx]).to.beIdenticalTo(group);
            }];
        });
        
        it(@"stores the destination node for reference", ^{
            expect([nodePath destinationNode]).to.beIdenticalTo(node);
        });
    };
    
    describe(@"using class initializer", ^{
        before(^{
            nodePath = [INLNodePath nodePathForDestinationNode:node];
        });
        
        itBehavesLikeItPointsToDestinationNode();
    });
    
    describe(@"using instance initializer", ^{
        before(^{
            nodePath = [[INLNodePath alloc] initWithDestinationNode:node];
        });
        
        itBehavesLikeItPointsToDestinationNode();
    });
});

SpecEnd
