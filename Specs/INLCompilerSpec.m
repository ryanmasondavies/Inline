//
//  INLCompilerSpec.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLCompiler)

__block INLCompiler *compiler;
before(^{ compiler = [[INLCompiler alloc] init]; });

describe(@"-invocationsForGroup:", ^{
    __block NSMutableArray *tests;
    before(^{
        tests = [NSMutableArray array];
        for (NSUInteger i = 0; i < 3; i ++) tests[i] = [[INLTest alloc] init];
    });
    
    it(@"should return invocations for top level tests", ^{
        INLGroup *group = [[INLGroup alloc] init];
        for (NSUInteger i = 0; i < 3; i ++) [group addTest:tests[i]];
        NSArray *invocations = [compiler invocationsForGroup:group];
        for (NSUInteger i = 0; i < 3; i ++) expect([invocations[i] test]).to.beIdenticalTo(tests[i]);
    });
    
    it(@"should move invocations for nested tests to the end of the list", ^{
        NSMutableArray *groups = [NSMutableArray array];
        for (NSUInteger i = 0; i < 3; i ++) groups[i] = [[INLGroup alloc] init];
        [groups[0] addGroup:groups[1]];
        [groups[1] addGroup:groups[2]];
        [groups[0] addTest:tests[0]];
        [groups[1] addTest:tests[1]];
        [groups[2] addTest:tests[2]];
        NSArray *invocations = [compiler invocationsForGroup:groups[0]];
        for (NSUInteger i = 0; i < 3; i ++) expect([invocations[i] test]).to.beIdenticalTo(tests[i]);
    });
});

SpecEnd
