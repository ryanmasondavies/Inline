//
//  INLBlockHookSpec.m
//  Inline
//
//  Created by Ryan Davies on 05/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLBlockHook)

void(^itShouldBehaveLikeANode)(Class) = ^(Class klass) {
    // TODO: Use shared examples to use this across INLGroup, INLTest, and INLHook without repeating.
    
    when(@"initialized with a parent", ^{
        it(@"is marked as belonging to the given parent", ^{
            INLGroup *parent = [[INLGroup alloc] init];
            INLNode *child = [[klass alloc] initWithParent:parent];
            expect([child parent]).to.beIdenticalTo(parent);
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

itShouldBehaveLikeANode([INLBlockHook class]);

describe(@"-execute", ^{
    it(@"should invoke the assigned block", ^{
        INLBlockHook *hook = [[INLBlockHook alloc] init];
        __block BOOL executed = NO;
        [hook setBlock:^{ executed = YES; }];
        [hook execute];
        expect(executed).to.beTruthy();
    });
});

SpecEnd
