//
//  INLInvocationSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLInvocation)

it(@"executes the test", ^{
    id test = [OCMockObject mockForClass:[INLTest class]];
    [[test expect] execute];
    INLInvocation *testInvocation = [INLInvocation invocationWithTest:test];
    [testInvocation invoke];
    [test verify];
});

SpecEnd
