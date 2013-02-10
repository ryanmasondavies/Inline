//
//  INLTestCaseSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTestCase)

describe(@"+testInvocations", ^{
    it(@"should return the result of passing the root group of the builder to the compiler", ^{
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
    it(@"should not contain SenTestCase", ^{
        expect([INLTestCase senAllSuperclasses]).notTo.contain([SenTestCase class]);
    });
});

describe(@"-name", ^{
    it(@"should be the description of the current test", ^{
        INLFakeTest *test = [[INLFakeTest alloc] initWithDescription:@"the test"];
        id invocation = [INLInvocation invocationWithTest:test];
        INLTestCase *testCase = [[INLTestCase alloc] initWithInvocation:invocation];
        expect([testCase name]).to.equal(@"the test");
    });
});

describe(@"each subclass", ^{
    it(@"should have its own instance of INLBuilder", ^{
        expect([INLTestCaseA builder]).to.beKindOf([INLBuilder class]);
        expect([INLTestCaseB builder]).to.beKindOf([INLBuilder class]);
        expect([INLTestCaseA builder]).toNot.beIdenticalTo([INLTestCaseB builder]);
    });
    
    it(@"should have its own instance of INLCompiler", ^{
        expect([INLTestCaseA compiler]).to.beKindOf([INLCompiler class]);
        expect([INLTestCaseB compiler]).to.beKindOf([INLCompiler class]);
        expect([INLTestCaseA compiler]).toNot.beIdenticalTo([INLTestCaseB compiler]);
    });
});

SpecEnd
