//
//  INLTestRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestRunnerTests : SenTestCase

@end

@implementation INLTestRunnerTests

- (void)testExecutesTests
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    INLTestRunner *runner = [[INLTestRunner alloc] init];
    [[test expect] execute];
    
    // when
    [runner visitTest:test];
    
    // then
    [test verify];
}

- (void)testExecutesHooks
{
    // given
    id hook = [OCMockObject mockForClass:[INLHook class]];
    INLTestRunner *runner = [[INLTestRunner alloc] init];
    [[hook expect] execute];
    
    // when
    [runner visitHook:hook];
    
    // then
    [hook verify];
}

@end
