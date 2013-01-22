//
//  INLTestCaseSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestCaseA : INLTestCase; @end
@interface INLTestCaseB : INLTestCase; @end

@implementation INLTestCaseA; @end
@implementation INLTestCaseB; @end

SpecBegin(INLTestCase)

NSArray * (^mockInvocations)(NSUInteger) = ^(NSUInteger count) {
    NSMutableArray *invocations = [NSMutableArray array];
    for (int i = 0; i < count; i ++)
        [invocations addObject:[OCMockObject niceMockForClass:[INLTestInvocation class]]];
    return invocations;
};

describe(@"+addTestInvocation", ^{
    it(@"should add test invocations per subclass", ^{
        NSArray *invocations = mockInvocations(2);
        
        [INLTestCaseA addTestInvocation:invocations[0]];
        [INLTestCaseB addTestInvocation:invocations[1]];
        
        expect([INLTestCaseA testInvocations]).to.contain(invocations[0]);
        expect([INLTestCaseA testInvocations]).to.contain(invocations[1]);
        expect([INLTestCaseB testInvocations]).to.contain(invocations[0]);
        expect([INLTestCaseB testInvocations]).to.contain(invocations[1]);
        
        [INLTestCaseA removeTestInvocation:invocations[0]];
        [INLTestCaseB removeTestInvocation:invocations[1]];
    });
});

describe(@"+removeTestInvocation", ^{
    it(@"should remove test invocations per subclass", ^{
        NSArray *invocations = mockInvocations(2);
        
        [INLTestCaseA addTestInvocation:invocations[0]];
        [INLTestCaseA addTestInvocation:invocations[1]];
        [INLTestCaseB addTestInvocation:invocations[0]];
        [INLTestCaseB addTestInvocation:invocations[1]];
        
        [INLTestCaseA removeTestInvocation:invocations[0]];
        [INLTestCaseB removeTestInvocation:invocations[1]];
        
        expect([INLTestCaseA testInvocations]).notTo.contain(invocations[0]);
        expect([INLTestCaseA testInvocations]).to.contain(invocations[1]);
        expect([INLTestCaseB testInvocations]).to.contain(invocations[0]);
        expect([INLTestCaseB testInvocations]).notTo.contain(invocations[1]);
        
        [INLTestCaseA removeTestInvocation:invocations[1]];
        [INLTestCaseB removeTestInvocation:invocations[0]];
    });
});

describe(@"-name", ^{
    it(@"should return the name of the current test", ^{
        id testInvocation = [OCMockObject niceMockForClass:[INLTestInvocation class]];
        id test = [OCMockObject mockForClass:[INLTest class]];
        [[[testInvocation stub] andReturn:test] test];
        [[[test stub] andReturn:@"the name"] name];
        
        INLTestCase *testCase = [[INLTestCase alloc] initWithInvocation:testInvocation];
        expect([testCase name]).to.equal(@"the name");
    });
});

SpecEnd
