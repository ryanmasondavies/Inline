//
//  INLTestInvocationSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLTestInvocation)

describe(@"-invoke", ^{
    it(@"should invoke the test", ^{
        id test = [OCMockObject mockForClass:[INLTest class]];
        [[test expect] execute];
        
        INLTestInvocation *testInvocation = [INLTestInvocation invocationWithTest:test];
        [testInvocation invoke];
        
        [test verify];
    });
});

SpecEnd
