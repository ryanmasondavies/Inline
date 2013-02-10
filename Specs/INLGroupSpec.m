//
//  INLGroupSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroup)

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

void(^itShouldBeEmpty)(INLGroup *) = ^(INLGroup *group) {
    it(@"should have no groups", ^{
        expect([group groups]).to.haveCountOf(0);
    });
    
    it(@"should have no tests", ^{
        expect([group tests]).to.haveCountOf(0);
    });
    
    it(@"should have no hooks", ^{
        expect([group hooks]).to.haveCountOf(0);
    });
};

__block INLGroup *group;
before(^{ group = [[INLGroup alloc] init]; });

itShouldBehaveLikeANode([INLGroup class]);

when(@"initialized", ^{
    itShouldBeEmpty([INLGroup new]);
});

when(@"a group is added", ^{
    __block INLGroup *child;
    before(^{ child = [[INLGroup alloc] init]; });
    void(^add)(void) = ^(void) { [group addGroup:child]; };
    
    it(@"should add it to 'groups'", ^{
        add(); expect([[group groups] lastObject]).to.beIdenticalTo(child);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([child parent]).to.beIdenticalTo(group);
    });
});

when(@"a test is added", ^{
    __block INLTest *test;
    before(^{ test = [[INLTest alloc] init]; });
    void(^add)(void) = ^(void) { [group addTest:test]; };
    
    it(@"should add it to 'tests'", ^{
        add(); expect([[group tests] lastObject]).to.beIdenticalTo(test);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([test parent]).to.beIdenticalTo(group);
    });
});

when(@"a hook is added", ^{
    __block INLHook *hook;
    before(^{ hook = [[INLHook alloc] init]; });
    void(^add)(void) = ^(void) { [group addHook:hook]; };
    
    it(@"should add it to 'hooks'", ^{
        add(); expect([[group hooks] lastObject]).to.beIdenticalTo(hook);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([hook parent]).to.beIdenticalTo(group);
    });
});

SpecEnd
