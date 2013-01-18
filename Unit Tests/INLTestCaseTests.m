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

@interface INLTestCaseTests : SenTestCase
@property (strong, nonatomic) NSMutableArray *invocations;
@end

@implementation INLTestCaseTests

- (void)setUp
{
    self.invocations = [NSMutableArray array];
    for (int i = 0; i < 2; i ++) {
        [[self invocations] addObject:[OCMockObject mockForClass:[INLTestInvocation class]]];
    }
}

- (void)testAddsTestInvocationsPerSubclass
{
    [INLTestCaseA addTestInvocation:self.invocations[0]];
    [INLTestCaseB addTestInvocation:self.invocations[1]];
    
    STAssertTrue ([[INLTestCaseA testInvocations] containsObject:self.invocations[0]], @"");
    STAssertFalse([[INLTestCaseA testInvocations] containsObject:self.invocations[1]], @"");
    STAssertFalse([[INLTestCaseB testInvocations] containsObject:self.invocations[0]], @"");
    STAssertTrue ([[INLTestCaseB testInvocations] containsObject:self.invocations[1]], @"");
    
    [INLTestCaseA removeTestInvocation:self.invocations[0]];
    [INLTestCaseB removeTestInvocation:self.invocations[1]];
}

- (void)testRemovesTestInvocationsPerSubclasses
{
    [INLTestCaseA addTestInvocation:self.invocations[0]];
    [INLTestCaseA addTestInvocation:self.invocations[1]];
    [INLTestCaseB addTestInvocation:self.invocations[0]];
    [INLTestCaseB addTestInvocation:self.invocations[1]];
    
    [INLTestCaseA removeTestInvocation:self.invocations[0]];
    [INLTestCaseB removeTestInvocation:self.invocations[1]];
    
    STAssertFalse([[INLTestCaseA testInvocations] containsObject:self.invocations[0]], @"");
    STAssertTrue ([[INLTestCaseA testInvocations] containsObject:self.invocations[1]], @"");
    STAssertTrue ([[INLTestCaseB testInvocations] containsObject:self.invocations[0]], @"");
    STAssertFalse([[INLTestCaseB testInvocations] containsObject:self.invocations[1]], @"");
    
    [INLTestCaseA removeTestInvocation:self.invocations[1]];
    [INLTestCaseB removeTestInvocation:self.invocations[0]];
}

@end
