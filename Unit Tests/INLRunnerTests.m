//
//  INLRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLRunnerTests : SenTestCase

@end

@implementation INLRunnerTests

- (void)testRunsTests
{
    // given
    id test = [OCMockObject mockForClass:[INLTest class]];
    INLRunner *runner = [[INLRunner alloc] init];
    [(INLTest *)[test expect] run];
    
    // when
    [runner visitTest:test];
    
    // then
    [test verify];
}

- (void)testRunsHooks
{
    // given
    id hook = [OCMockObject mockForClass:[INLHook class]];
    INLRunner *runner = [[INLRunner alloc] init];
    [(INLHook *)[hook expect] run];
    
    // when
    [runner visitHook:hook];
    
    // then
    [hook verify];
}

@end
