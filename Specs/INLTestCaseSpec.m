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
        
        [INLTestCaseA setBuilder:nil];
        [INLTestCaseB setBuilder:nil];
    });
});

describe(@"+compiler", ^{
    it(@"should be per-subclass", ^{
        NSMutableArray *compilers = [NSMutableArray array];
        for (NSUInteger i = 0; i < 2; i ++)
            compilers[i] = [OCMockObject niceMockForProtocol:@protocol(INLTestCompiler)];
        
        [INLTestCaseA setCompiler:compilers[0]];
        [INLTestCaseB setCompiler:compilers[1]];
        
        expect([INLTestCaseA compiler]).to.beIdenticalTo(compilers[0]);
        expect([INLTestCaseB compiler]).to.beIdenticalTo(compilers[1]);
        
        [INLTestCaseA setCompiler:nil];
        [INLTestCaseB setCompiler:nil];
    });
});

describe(@"+testInvocations", ^{
    it(@"should pass tests from the builder to the compiler", ^{
        id builder  = [OCMockObject mockForProtocol:@protocol(INLTestBuilder)];
        id compiler = [OCMockObject mockForProtocol:@protocol(INLTestCompiler)];
        
        NSArray *tests = [NSArray array];
        NSArray *invocations = [NSArray array];
        
        [[[builder expect] andReturn:tests] tests];
        [[[compiler expect] andReturn:invocations] invocationsForTests:tests];
        
        [INLTestCase setBuilder:builder];
        [INLTestCase setCompiler:compiler];
        
        expect([INLTestCase testInvocations]).to.beIdenticalTo(invocations);
        
        [builder verify];
        
        [INLTestCase setBuilder:nil];
        [INLTestCase setCompiler:nil];
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
