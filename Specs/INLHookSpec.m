//
//  INLHookSpec.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLHook)

void(^itShouldBehaveLikeANode)(Class) = ^(Class klass) {
    // TODO: Use shared examples to use this across INLGroup, INLTest, and INLHook without repeating.
    
    when(@"initialized with a parent", ^{
        it(@"is marked as belonging to the given parent", ^{
            INLGroup *parent = [[INLGroup alloc] init];
            INLNode *child = [[klass alloc] initWithParent:parent];
            expect([child parent]).to.beIdenticalTo(parent);
        });
    });
    
    describe(@"path", ^{
        it(@"is built up of the groups leading to the test", ^{
            NSMutableArray *groups = [NSMutableArray array];
            for (NSUInteger i = 0; i < 5; i ++) groups[i] = [[INLGroup alloc] initWithParent:((i > 0) ? groups[i-1] : nil)];
            INLNode *node = [[klass alloc] initWithParent:[groups lastObject]];
            for (NSUInteger i = 0; i < 5; i ++) expect([node path][i]).to.beIdenticalTo(groups[i]);
        });
    });
};

itShouldBehaveLikeANode([INLHook class]);

SpecEnd
