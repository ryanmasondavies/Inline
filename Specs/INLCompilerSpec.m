//
//  INLCompilerSpec.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLCompiler)

id (^mockGroup)(NSArray *, NSArray *) = ^(NSArray *tests, NSArray *groups) {
    id group = [OCMockObject mockForClass:[INLGroup class]];
    [[[group stub] andReturn:tests] tests];
    [[[group stub] andReturn:groups] groups];
    return group;
};

NSArray *(^mockTests)(NSUInteger) = ^(NSUInteger count) {
    NSMutableArray *tests = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i ++) tests[i] = [OCMockObject niceMockForClass:[INLTest class]];
    return tests;
};

__block INLCompiler *compiler;
before(^{ compiler = [[INLCompiler alloc] init]; });

describe(@"-invocationsForGroup:", ^{
    it(@"should return invocations for top level tests", ^{
        NSArray *tests = mockTests(2);
        id group = mockGroup(tests, @[]);
       
        NSArray *invocations = [compiler invocationsForGroup:group];
       
        expect([invocations[0] test]).to.beIdenticalTo(tests[0]);
        expect([invocations[1] test]).to.beIdenticalTo(tests[1]);
    });
    
    it(@"should move invocations for nested tests to the end of the list", ^{
        NSArray *tests = mockTests(3);
        id nestedGroup = mockGroup(@[tests[1]], @[]);
        id topGroup = mockGroup(@[tests[0], tests[2]], @[nestedGroup]);
        NSArray *invocations = [compiler invocationsForGroup:topGroup];
        expect([invocations[0] test]).to.beIdenticalTo(tests[0]);
        expect([invocations[1] test]).to.beIdenticalTo(tests[2]);
        expect([invocations[2] test]).to.beIdenticalTo(tests[1]);
    });
});

SpecEnd
