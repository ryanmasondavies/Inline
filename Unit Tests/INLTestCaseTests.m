//
//  INLTestCaseTests.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestCaseA : INLTestCase; @end
@interface INLTestCaseB : INLTestCase; @end

@implementation INLTestCaseA; @end
@implementation INLTestCaseB; @end

@interface INLTestCaseTests : SenTestCase; @end

@implementation INLTestCaseTests

NSArray * (^mockInvocations)(NSUInteger) = ^(NSUInteger count) {
    NSMutableArray *invocations = [NSMutableArray array];
    for (int i = 0; i < count; i ++)
        [invocations addObject:[OCMockObject mockForClass:[INLTestInvocation class]]];
    return invocations;
};

- (void)testAddsTestInvocationsPerSubclass
{
    NSArray *invocations = mockInvocations(2);
    
    [INLTestCaseA addTestInvocation:invocations[0]];
    [INLTestCaseB addTestInvocation:invocations[1]];
    
    STAssertTrue ([[INLTestCaseA testInvocations] containsObject:invocations[0]], @"");
    STAssertFalse([[INLTestCaseA testInvocations] containsObject:invocations[1]], @"");
    STAssertFalse([[INLTestCaseB testInvocations] containsObject:invocations[0]], @"");
    STAssertTrue ([[INLTestCaseB testInvocations] containsObject:invocations[1]], @"");
    
    [INLTestCaseA removeTestInvocation:invocations[0]];
    [INLTestCaseB removeTestInvocation:invocations[1]];
}

- (void)testRemovesTestInvocationsPerSubclasses
{
    NSArray *invocations = mockInvocations(2);
    
    [INLTestCaseA addTestInvocation:invocations[0]];
    [INLTestCaseA addTestInvocation:invocations[1]];
    [INLTestCaseB addTestInvocation:invocations[0]];
    [INLTestCaseB addTestInvocation:invocations[1]];
    
    [INLTestCaseA removeTestInvocation:invocations[0]];
    [INLTestCaseB removeTestInvocation:invocations[1]];
    
    STAssertFalse([[INLTestCaseA testInvocations] containsObject:invocations[0]], @"");
    STAssertTrue ([[INLTestCaseA testInvocations] containsObject:invocations[1]], @"");
    STAssertTrue ([[INLTestCaseB testInvocations] containsObject:invocations[0]], @"");
    STAssertFalse([[INLTestCaseB testInvocations] containsObject:invocations[1]], @"");
    
    [INLTestCaseA removeTestInvocation:invocations[1]];
    [INLTestCaseB removeTestInvocation:invocations[0]];
}

- (void)testReturnsTestName
{
    id testInvocation = [OCMockObject niceMockForClass:[INLTestInvocation class]];
    id test = [OCMockObject mockForClass:[INLTest class]];
    [[[testInvocation stub] andReturn:test] test];
    [[[test stub] andReturn:@"the name"] name];
    
    INLTestCase *testCase = [[INLTestCase alloc] initWithInvocation:testInvocation];
    STAssertEqualObjects([testCase name], @"the name", @"");
}

@end
