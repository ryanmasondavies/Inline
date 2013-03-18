//
//  INLInvocationTests.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLInvocationTests : SenTestCase
@end

@implementation INLInvocationTests

- (void)testExecutesTest
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    [[test expect] execute];
    INLInvocation *testInvocation = [INLInvocation invocationWithTest:test];
    
    // when
    [testInvocation invoke];
    
    // then
    [test verify];
}

@end
