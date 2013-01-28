//
//  INLInvocationSpec.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLInvocation)

describe(@"-invoke", ^{
    it(@"should invoke the test", ^{
        id test = [OCMockObject mockForProtocol:@protocol(INLTest)];
        [[test expect] execute];
        
        INLInvocation *testInvocation = [INLInvocation invocationWithTest:test];
        [testInvocation invoke];
        
        [test verify];
    });
});

SpecEnd
