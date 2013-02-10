//
//  INLHookSpec.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLHook)

void(^itShouldBehaveLikeANode)(Class, NSString *) = ^(Class klass, NSString *collectionKey) {
    // TODO: Use shared examples to use this across INLGroup, INLTest, and INLHook without repeating.
    
    when(@"initialized with a parent", ^{
        it(@"adds the node to the parent", ^{
            INLGroup *parent = [[INLGroup alloc] init];
            INLNode *child = [[klass alloc] initWithParent:parent];
            expect([parent valueForKey:collectionKey]).to.contain(child);
        });
    });
    
    when(@"assigned to a new parent", ^{
        __block INLNode  *node;
        __block INLGroup *oldParent;
        __block INLGroup *newParent;
        
        before(^{
            node      = [[INLNode  alloc] init];
            oldParent = [[INLGroup alloc] init];
            newParent = [[INLGroup alloc] init];
            [oldParent addNode:node];
        });
        
        void(^assign)(void) = ^(void) {
            [node setParent:newParent];
        };
        
        it(@"removes it from the old parent", ^{
            assign();
            expect([oldParent valueForKey:collectionKey]).toNot.contain(node);
        });
        
        it(@"adds it to the new parent", ^{
            assign();
            expect([newParent valueForKey:collectionKey]).to.contain(node);
        });
    });
    
    describe(@"node path", ^{
        __block INLNode     *node;
        __block INLNodePath *nodePath;
        
        before(^{
            node = [[klass alloc] init];
            nodePath = [node nodePath];
        });
        
        it(@"points to the node", ^{
            expect([nodePath destinationNode]).to.beIdenticalTo(node);
        });
    });
};

itShouldBehaveLikeANode([INLHook class], @"hooks");

SpecEnd
