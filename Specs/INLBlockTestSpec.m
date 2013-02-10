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
before(^{ test = [[INLBlockTest alloc] init]; });

describe(@"-setBlock:", ^{
    it(@"should set test state to 'ready'", ^{
        [test setBlock:^{}];
        expect([test state]).to.equal(INLTestStateReady);
    });
    
    when(@"passing in nil", ^{
        it(@"should set test state to 'pending'", ^{
            [test setState:INLTestStateReady];
            [test setBlock:nil];
            expect([test state]).to.equal(INLTestStatePending);
        });
    });
});

describe(@"-execute", ^{
    before(^{ test = [OCMockObject partialMockForObject:test]; });
    
    when(@"ready", ^{
        it(@"should execute before hooks", ^{
            __block BOOL performedExecutedBeforeHooks = NO;
            [[[test expect] andDo:^(NSInvocation *invocation) { performedExecutedBeforeHooks = YES; }] executeBeforeHooks];
            [test setBlock:^{ expect(performedExecutedBeforeHooks).to.beTruthy(); }];
            [test execute];
            [test verify];
        });
        
        it(@"should invoke the block", ^{
            __block BOOL executed = NO;
            [test setBlock:^{ executed = YES; }];
            [test execute];
            expect(executed).to.beTruthy();
        });
        
        it(@"should execute after hooks", ^{
            __block BOOL performedBlock = NO;
            [test setBlock:^{ performedBlock = YES; }];
            [[[test expect] andDo:^(NSInvocation *invocation) { expect(performedBlock).to.beTruthy(); }] executeAfterHooks];
            [test execute];
            [test verify];
        });
        
        it(@"should mark test as executed", ^{
            [test setBlock:^{}];
            [test execute];
            expect([test state]).to.equal(INLTestStateExecuted);
        });
    });
    
    when(@"pending", ^{
        it(@"should remain pending", ^{
            [test setState:INLTestStatePending];
            [test execute];
            expect([test state]).to.equal(INLTestStatePending);
        });
    });
});

SpecEnd
