//
//  INLBlockTestTests.m
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLBlockTestTests : SenTestCase
@property (strong, nonatomic) id test;
@end

@implementation INLBlockTestTests

- (void)setUp
{
    self.test = [[INLBlockTest alloc] init];
}

- (void)testAssigningNewBlockSetsStateToReady
{
    [[self test] setBlock:^{}];
    [[@([[self test] state]) should] beEqualTo:@(INLTestStateReady)];
}

- (void)testAssigningNilBlockSetsStateToPending
{
    [[self test] setState:INLTestStateReady];
    [[self test] setBlock:nil];
    [[@([[self test] state]) should] beEqualTo:@(INLTestStatePending)];
}

- (void)testExecutionWhenReadyExecutesHooksAroundBlock
{
    INLTest *realTest = [self test];
    [self setTest:[OCMockObject partialMockForObject:realTest]];
    
    OCMArg *nodePathCheck = [OCMArg checkWithBlock:^BOOL(id nodePath) {
        return [nodePath destinationNode] == realTest;
    }];
    
    __block NSString *step = @"";
    [[[[self test] expect] andDo:^(NSInvocation *invocation) {
        step = @"before";
    }] executeHooksInNodePath:(id)nodePathCheck placement:INLHookPlacementBefore];
    
    [[[[self test] expect] andDo:^(NSInvocation *invocation) {
        step = @"after";
    }] executeHooksInNodePath:(id)nodePathCheck placement:INLHookPlacementAfter];
    
    [[self test] setBlock:^{
        [[step should] beEqualTo:@"before"];
    }];
    
    [[self test] execute];
    [[self test] verify];
}

- (void)testExecutionWhenReadySetsStateToExecuted
{
    [[self test] setBlock:^{}];
    [[self test] execute];
    [[@([[self test] state]) should] beEqualTo:@(INLTestStateExecuted)];
}

- (void)testExecutionWhenPendingRemainsPending
{
    [[self test] setState:INLTestStatePending];
    [[self test] execute];
    [[@([[self test] state]) should] beEqualTo:@(INLTestStatePending)];
}

@end
