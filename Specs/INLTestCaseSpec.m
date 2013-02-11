//
//  INLTestCaseSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTestCase)

it(@"returns invocations for each test that has been added to the builder", ^{
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

it(@"uses the description of the current test for its name", ^{
    INLFakeTest *test = [[INLFakeTest alloc] initWithDescription:@"the test"];
    id invocation = [INLInvocation invocationWithTest:test];
    INLTestCase *testCase = [[INLTestCase alloc] initWithInvocation:invocation];
    expect([testCase name]).to.equal(@"the test");
});

it(@"does not include SenTestCase in its list of superclasses", ^{
    expect([INLTestCase senAllSuperclasses]).notTo.contain([SenTestCase class]);
});

it(@"does not share builders between subclasses", ^{
    expect([INLTestCaseA builder]).to.beKindOf([INLBuilder class]);
    expect([INLTestCaseB builder]).to.beKindOf([INLBuilder class]);
    expect([INLTestCaseA builder]).toNot.beIdenticalTo([INLTestCaseB builder]);
});

it(@"does not share compilers between subclasses", ^{
    expect([INLTestCaseA compiler]).to.beKindOf([INLCompiler class]);
    expect([INLTestCaseB compiler]).to.beKindOf([INLCompiler class]);
    expect([INLTestCaseA compiler]).toNot.beIdenticalTo([INLTestCaseB compiler]);
});

SpecEnd
