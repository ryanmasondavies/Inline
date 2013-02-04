//
//  INLTestSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTest)

__block INLTest        *test;
__block NSMutableArray *hooks;
__block NSMutableArray *groups;
__block NSMutableArray *order;

NSMutableArray *(^mockGroup)(NSArray *, id) = ^(NSArray *hooks, id parent) {
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:hooks] hooks];
    [[[group stub] andReturn:parent] parent];
    return group;
};

before(^{
    test   = [[INLTest alloc] init];
    hooks  = [NSMutableArray array];
    groups = [NSMutableArray array];
    order  = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        hooks[i] = [OCMockObject niceMockForClass:[INLHook class]];
        [[[hooks[i] expect] andDo:^(NSInvocation *invocation) { [order addObject:hooks[i]]; }] execute];
    }
    
    for (NSUInteger i = 0; i < 3; i ++)
        groups[i] = mockGroup(@[hooks[i]], (i > 0) ? groups[i-1] : nil);
    
    [test setParent:[groups lastObject]];
});

describe(@"state", ^{
    it(@"should be pending", ^{
        expect([test state]).to.equal(INLTestStatePending);
    });
});

describe(@"-executeBeforeHooks", ^{
    before(^{
        [hooks enumerateObjectsUsingBlock:^(id hook, NSUInteger idx, BOOL *stop) {
            [[[hook stub] andReturnValue:OCMOCK_VALUE((INLHookPlacement){INLHookPlacementBefore})] placement];
        }];
    });
    
    it(@"should execute hooks in forward order", ^{
        [test executeBeforeHooks];
        expect(order[0]).to.beIdenticalTo(hooks[0]);
        expect(order[1]).to.beIdenticalTo(hooks[1]);
        expect(order[2]).to.beIdenticalTo(hooks[2]);
    });
    
    // This would be much easier if the return value of a stub could be modified.
    it(@"should not execute hooks with a placement of 'after'", ^{
        id hook = [OCMockObject mockForClass:[INLHook class]];
        [[[hook stub] andReturnValue:OCMOCK_VALUE((INLHookPlacement){INLHookPlacementAfter})] placement];
        [[hook reject] execute];
        
        groups[2] = mockGroup(@[hook], groups[1]);
        [test setParent:groups[2]];
        
        [test executeBeforeHooks];
        [hook verify];
    });
    
    it(@"should ignore hooks in sibling groups", ^{
        id sibling = [OCMockObject niceMockForClass:[INLGroup class]];
        [[[sibling stub] andReturn:groups[1]] parent];
        
        id hook = [OCMockObject niceMockForClass:[INLHook class]];
        [[[hook stub] andReturn:sibling] parent];
        [[hook reject] execute];
        
        [test executeBeforeHooks];
        [hook verify];
    });
    
    it(@"should ignore hooks in more deeply nested groups", ^{
        id descendant = [OCMockObject niceMockForClass:[INLGroup class]];
        [[[descendant stub] andReturn:groups[2]] parent];
        
        id hook = [OCMockObject niceMockForClass:[INLHook class]];
        [[[hook stub] andReturn:descendant] parent];
        [[hook reject] execute];
        
        [test executeBeforeHooks];
        [hook verify];
    });
});

describe(@"-executeAfterHooks", ^{
    before(^{
        [hooks enumerateObjectsUsingBlock:^(id hook, NSUInteger idx, BOOL *stop) {
            [[[hook stub] andReturnValue:OCMOCK_VALUE((INLHookPlacement){INLHookPlacementAfter})] placement];
        }];
    });
    
    it(@"should execute hooks in outward order", ^{
        [test executeAfterHooks];
        expect(order[0]).to.beIdenticalTo(hooks[2]);
        expect(order[1]).to.beIdenticalTo(hooks[1]);
        expect(order[2]).to.beIdenticalTo(hooks[0]);
    });
    
    // This would be much easier if the return value of a stub could be modified.
    it(@"should not execute hooks with a placement of 'before'", ^{
        id hook = [OCMockObject mockForClass:[INLHook class]];
        [[[hook stub] andReturnValue:OCMOCK_VALUE((INLHookPlacement){INLHookPlacementBefore})] placement];
        [[hook reject] execute];
        
        groups[2] = mockGroup(@[hook], groups[1]);
        [test setParent:groups[2]];
        
        [test executeAfterHooks];
        [hook verify];
    });
    
    it(@"should ignore hooks in sibling groups", ^{
        id sibling = [OCMockObject niceMockForClass:[INLGroup class]];
        [[[sibling stub] andReturn:groups[1]] parent];
        
        id hook = [OCMockObject niceMockForClass:[INLHook class]];
        [[[hook stub] andReturn:sibling] parent];
        [[hook reject] execute];
        
        [test executeAfterHooks];
        [hook verify];
    });
    
    it(@"should ignore hooks in more deeply nested groups", ^{
        id descendant = [OCMockObject niceMockForClass:[INLGroup class]];
        [[[descendant stub] andReturn:groups[2]] parent];
        
        id hook = [OCMockObject niceMockForClass:[INLHook class]];
        [[[hook stub] andReturn:descendant] parent];
        [[hook reject] execute];
        
        [test executeAfterHooks];
        [hook verify];
    });
});

SpecEnd
