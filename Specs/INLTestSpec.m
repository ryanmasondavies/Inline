//
//  INLTestSpec.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTest)

__block NSMutableArray *hooks;
__block NSMutableArray *groups;
__block NSMutableArray *order;
__block INLTest        *test;

before(^{
    hooks  = [NSMutableArray array];
    groups = [NSMutableArray array];
    order  = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        groups[i] = [[INLGroup alloc] initWithParent:((i > 0) ? groups[i-1] : nil)];
        hooks[i] = [OCMockObject partialMockForObject:[[INLHook alloc] init]];
        [[[hooks[i] expect] andDo:^(NSInvocation *invocation) { [order addObject:hooks[i]]; }] execute];
        [groups[i] addHook:hooks[i]];
    }
    
    test = [[INLTest alloc] initWithParent:[groups lastObject]];
});

when(@"initialized", ^{
    it(@"should be in 'pending' state'", ^{
        expect([test state]).to.equal(INLTestStatePending);
    });
});

when(@"initialized with a parent", ^{
    it(@"should be in 'pending' state", ^{
        expect([test state]).to.equal(INLTestStatePending);
    });
    
    it(@"should create a test with the given parent", ^{
        INLGroup *parent = [[INLGroup alloc] init];
        INLTest *child = [[INLTest alloc] initWithParent:parent];
        expect([child parent]).to.beIdenticalTo(parent);
    });
});

when(@"before hooks are executed", ^{
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
        [groups[2] setHooks:@[hook]];
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

when(@"after hooks are executed", ^{
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
    
    it(@"should not execute hooks with a placement of 'before'", ^{
        id hook = [OCMockObject mockForClass:[INLHook class]];
        [[[hook stub] andReturnValue:OCMOCK_VALUE((INLHookPlacement){INLHookPlacementBefore})] placement];
        [[hook reject] execute];
        [groups[2] setHooks:@[hook]];
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
