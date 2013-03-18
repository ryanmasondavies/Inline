//
//  INLNodeRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNodeRunnerTests : SenTestCase

@end

@implementation INLNodeRunnerTests

- (void)testRunsTests
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    INLNodeRunner *runner = [[INLNodeRunner alloc] init];
    [(INLTest *)[test expect] run];
    
    // when
    [runner visitTest:test];
    
    // then
    [test verify];
}

- (void)testExecutesHooks
{
    // given
    id hook = [OCMockObject mockForClass:[INLHook class]];
    INLNodeRunner *runner = [[INLNodeRunner alloc] init];
    [(INLHook *)[hook expect] run];
    
    // when
    [runner visitHook:hook];
    
    // then
    [hook verify];
}

@end
