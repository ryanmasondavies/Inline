//
//  INLCompilerSpec.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLCompiler)

__block INLCompiler *compiler;
__block NSMutableArray *tests;

before(^{
    compiler = [[INLCompiler alloc] init];
    tests = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        tests[i] = [[INLTest alloc] init];
    }
});
    
it(@"creates invocations for top level tests", ^{
    INLGroup *group = [[INLGroup alloc] init];
    for (NSUInteger i = 0; i < 3; i ++) [group addNode:tests[i]];
    NSArray *invocations = [compiler invocationsForGroup:group];
    for (NSUInteger i = 0; i < 3; i ++) expect([invocations[i] test]).to.beIdenticalTo(tests[i]);
});

it(@"moves invocations for nested tests to the end of the list", ^{
    NSMutableArray *groups = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; i ++) groups[i] = [[INLGroup alloc] init];
    [groups[0] addNode:groups[1]];
    [groups[1] addNode:groups[2]];
    [groups[0] addNode:tests[0]];
    [groups[1] addNode:tests[1]];
    [groups[2] addNode:tests[2]];
    NSArray *invocations = [compiler invocationsForGroup:groups[0]];
    for (NSUInteger i = 0; i < 3; i ++) expect([invocations[i] test]).to.beIdenticalTo(tests[i]);
});

SpecEnd
