//
//  INLTestInvocationTests.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestInvocationTests : SenTestCase
@end

@implementation INLTestInvocationTests

- (void)testInvokesExample
{
    id test = [OCMockObject mockForClass:[INLTest class]];
    [[test expect] execute];
    
    INLTestInvocation *testInvocation = [INLTestInvocation invocationWithTest:test];
    [testInvocation invoke];
    
    [test verify];
}

@end
