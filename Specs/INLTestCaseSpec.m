//
//  INLTestCaseSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTestCase)

describe(@"+builder", ^{
    it(@"should, by default, be an instance of INLBuilder", ^{
        expect([INLTestCase builder]).to.beKindOf([INLBuilder class]);
    });
    
    it(@"should be per-subclass", ^{
        NSMutableArray *builders = [NSMutableArray array];
        for (NSUInteger i = 0; i < 2; i ++) builders[i] = [[INLBuilder alloc] init];
        [INLTestCaseA setBuilder:builders[0]];
        [INLTestCaseB setBuilder:builders[1]];
        expect([INLTestCaseA builder]).to.beIdenticalTo(builders[0]);
        expect([INLTestCaseB builder]).to.beIdenticalTo(builders[1]);
        [INLTestCaseA setBuilder:nil];
        [INLTestCaseB setBuilder:nil];
    });
});

describe(@"+compiler", ^{
    it(@"should, by default, be an instance of INLCompiler", ^{
        expect([INLTestCase compiler]).to.beKindOf([INLCompiler class]);
    });
    
    it(@"should be per-subclass", ^{
        NSMutableArray *compilers = [NSMutableArray array];
        for (NSUInteger i = 0; i < 2; i ++) compilers[i] = [[INLCompiler alloc] init];
        [INLTestCaseA setCompiler:compilers[0]];
        [INLTestCaseB setCompiler:compilers[1]];
        expect([INLTestCaseA compiler]).to.beIdenticalTo(compilers[0]);
        expect([INLTestCaseB compiler]).to.beIdenticalTo(compilers[1]);
        [INLTestCaseA setCompiler:nil];
        [INLTestCaseB setCompiler:nil];
    });
});

describe(@"+testInvocations", ^{
    it(@"should pass the root group of the builder to the compiler", ^{
        INLBuilder  *builder  = [OCMockObject mockForClass:[INLBuilder class]];
        INLCompiler *compiler = [OCMockObject mockForClass:[INLCompiler class]];
        INLGroup *group = [[INLGroup alloc] init];
        NSArray *invocations = [NSArray array];
        [[[(id)builder expect] andReturn:group] rootGroup];
        [[[(id)compiler expect] andReturn:invocations] invocationsForGroup:group];
        [INLTestCase setBuilder:builder];
        [INLTestCase setCompiler:compiler];
        expect([INLTestCase testInvocations]).to.beIdenticalTo(invocations);
        [(id)builder verify];
        [INLTestCase setBuilder:nil];
        [INLTestCase setCompiler:nil];
    });
});

describe(@"+senAllSuperclasses", ^{
    it(@"should return an array without SenTestCase for blacklisted classes", ^{
        expect([INLBlacklistedTestCase senAllSuperclasses]).notTo.contain([SenTestCase class]);
    });
    
    it(@"should return an array containing SenTestCase for classes which are not blacklisted", ^{
        expect([INLTestCaseA senAllSuperclasses]).to.contain([SenTestCase class]);
    });
});

describe(@"+blacklistedClasses", ^{
    it(@"should contain INLTestCase", ^{
        expect([INLTestCase blacklistedClasses]).to.contain([INLTestCase class]);
    });
});

describe(@"-name", ^{
    it(@"should return the description of the current test", ^{
        INLFakeTest *test = [[INLFakeTest alloc] initWithDescription:@"the test"];
        id invocation = [INLInvocation invocationWithTest:test];
        INLTestCase *testCase = [[INLTestCase alloc] initWithInvocation:invocation];
        expect([testCase name]).to.equal(@"the test");
    });
});

SpecEnd
