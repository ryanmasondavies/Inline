//
//  INLGroupSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroup)

__block INLGroup *group;

before(^{
    group = [[INLGroup alloc] init];
});

when(@"a group is added", ^{
    __block INLGroup *child;
    
    before(^{
        child = [[INLGroup alloc] init];
    });
    
    void(^add)(void) = ^(void) {
        [group addNode:child];
    };
    
    it(@"should add it to 'groups'", ^{
        add(); expect([group groups][0]).to.beIdenticalTo(child);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([child parent]).to.beIdenticalTo(group);
    });
});

when(@"a test is added", ^{
    __block INLTest *test;
    
    before(^{
        test = [[INLTest alloc] init];
    });
    
    void(^add)(void) = ^(void) {
        [group addNode:test];
    };
    
    it(@"should add it to 'tests'", ^{
        add(); expect([group tests][0]).to.beIdenticalTo(test);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([test parent]).to.beIdenticalTo(group);
    });
});

when(@"a hook is added", ^{
    __block INLHook *hook;
    
    before(^{
        hook = [[INLHook alloc] init];
    });
    
    void(^add)(void) = ^(void) {
        [group addNode:hook];
    };
    
    it(@"should add it to 'hooks'", ^{
        add(); expect([group hooks][0]).to.beIdenticalTo(hook);
    });
    
    it(@"should mark it as a child of the parent group", ^{
        add(); expect([hook parent]).to.beIdenticalTo(group);
    });
});

when(@"a group is removed", ^{
    __block INLGroup *child;
    
    before(^{
        child = [[INLGroup alloc] init];
        [group addNode:child];
    });
    
    void(^remove)(void) = ^(void) {
        [group removeNode:child];
    };
    
    it(@"should remove it from 'groups'", ^{
        remove(); expect([group groups]).toNot.contain(child);
    });
    
    it(@"should mark it as independent from the parent group", ^{
        remove(); expect([child parent]).to.beNil();
    });
});

when(@"a test is removed", ^{
    __block INLTest *test;
    
    before(^{
        test = [[INLTest alloc] init];
        [group addNode:test];
    });
    
    void(^remove)(void) = ^(void) {
        [group removeNode:test];
    };
    
    it(@"should remove it from 'tests'", ^{
        remove();
        expect([group tests]).toNot.contain(test);
    });
    
    it(@"should mark it as independent from the parent group", ^{
        remove();
        expect([test parent]).to.beNil();
    });
});

when(@"a test is removed", ^{
    __block INLHook *hook;
    
    before(^{
        hook = [[INLHook alloc] init];
        [group addNode:hook];
    });
    
    void(^remove)(void) = ^(void) {
        [group removeNode:hook];
    };
    
    it(@"should remove it from 'hooks'", ^{
        remove();
        expect([group hooks]).toNot.contain(hook);
    });
    
    it(@"should mark it as independent from the parent group", ^{
        remove();
        expect([hook parent]).to.beNil();
    });
});

SpecEnd
