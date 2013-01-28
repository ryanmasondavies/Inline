//
//  INLGroupSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroup)

__block INLGroup *group;
before(^{ group = [[INLGroup alloc] init]; });

when(@"newly created", ^{
    it(@"should have no groups", ^{
        expect([group groups]).to.haveCountOf(0);
    });
    
    it(@"should have no tests", ^{
        expect([group tests]).to.haveCountOf(0);
    });
    
    it(@"should have no hooks", ^{
        expect([group hooks]).to.haveCountOf(0);
    });
});

describe(@"-addGroup:", ^{
    __block INLGroup *child;
    before(^{ child = [[INLGroup alloc] init]; });
    
    it(@"should add a new group to `groups`", ^{
        [group addGroup:child];
        expect([[group groups] lastObject]).to.beIdenticalTo(child);
    });
    
    it(@"should assign the group as the parent for the added group", ^{
        [group addGroup:child];
        expect([child parent]).to.beIdenticalTo(group);
    });
});

describe(@"-addTest:", ^{
    __block id test;
    before(^{ test = [OCMockObject niceMockForClass:[INLTest class]]; });
    
    it(@"should add a new test to `tests`", ^{
        [group addTest:test];
        expect([[group tests] lastObject]).to.beIdenticalTo(test);
    });
    
    it(@"should assign the group as the parent for the test", ^{
        [[test expect] setParent:group];
        [group addTest:test];
        [test verify];
    });
});

describe(@"-addHook:", ^{
    __block id hook;
    before(^{ hook = [OCMockObject niceMockForClass:[INLHook class]]; });
    
    it(@"should add a new hook to `hooks`", ^{
        [group addHook:hook];
        expect([[group hooks] lastObject]).to.beIdenticalTo(hook);
    });
    
    it(@"should assign the group as the parent for the hook", ^{
        [[hook expect] setParent:group];
        [group addHook:hook];
        [hook verify];
    });
});

SpecEnd
