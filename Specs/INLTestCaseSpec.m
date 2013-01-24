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

describe(@"+builder", ^{
    it(@"should be per-subclass", ^{
        NSMutableArray *builders = [NSMutableArray array];
        for (NSUInteger i = 0; i < 2; i ++)
            builders[i] = [OCMockObject niceMockForProtocol:@protocol(INLTestBuilder)];
        
        [INLTestCaseA setBuilder:builders[0]];
        [INLTestCaseB setBuilder:builders[1]];
        
        expect([INLTestCaseA builder]).to.beIdenticalTo(builders[0]);
        expect([INLTestCaseB builder]).to.beIdenticalTo(builders[1]);
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
