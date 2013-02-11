//
//  INLBlockTestSpec.m
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLBlockTest)

// TODO: Shared examples would allow BlockTest to verify the behaviour provided by INLTest.

__block id test;

before(^{
    test = [[INLBlockTest alloc] init];
});

describe(@"-setBlock:", ^{
    it(@"sets test state to 'ready'", ^{
        [test setBlock:^{}];
        expect([test state]).to.equal(INLTestStateReady);
    });
    
    when(@"passing in nil", ^{
        it(@"sets test state to 'pending'", ^{
            [test setState:INLTestStateReady];
            [test setBlock:nil];
            expect([test state]).to.equal(INLTestStatePending);
        });
    });
});

when(@"executed", ^{
    __block INLTest *realTest;
    
    before(^{
        realTest = test;
        test = [OCMockObject partialMockForObject:test];
    });
    
    when(@"ready", ^{
        it(@"executes hooks around block", ^{
            OCMArg *nodePathCheck = [OCMArg checkWithBlock:^BOOL(id nodePath) {
                return [nodePath destinationNode] == realTest;
            }];
            
            __block NSString *step = @"";
            [[[test expect] andDo:^(NSInvocation *invocation) {
                step = @"before";
            }] executeHooksInNodePath:(id)nodePathCheck placement:INLHookPlacementBefore];
            
            [[[test expect] andDo:^(NSInvocation *invocation) {
                step = @"after";
            }] executeHooksInNodePath:(id)nodePathCheck placement:INLHookPlacementAfter];
            
            [test setBlock:^{
                expect(step).to.equal(@"before");
            }];
            
            [test execute];
            [test verify];
        });
        
        it(@"marks test as executed", ^{
            [test setBlock:^{}];
            [test execute];
            expect([test state]).to.equal(INLTestStateExecuted);
        });
    });
    
    when(@"pending", ^{
        it(@"remains pending", ^{
            [test setState:INLTestStatePending];
            [test execute];
            expect([test state]).to.equal(INLTestStatePending);
        });
    });
});

SpecEnd
