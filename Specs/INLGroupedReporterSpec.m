//
//  INLGroupedReporterSpec.m
//  Inline
//
//  Created by Ryan Davies on 06/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroupedReporter)

NSNotification *(^notificationForSuite)(NSString *, NSString *) = ^(NSString *notificationName, NSString *suiteName) {
    INLInvocation  *invocation = [INLInvocation invocationWithTest:nil];
    SenTestCase    *testCase   = [OCMockObject mockForClass:[SenTestCase class]];
    SenTestRun     *run        = [[SenTestRun alloc] initWithTest:testCase];
    [[[(id)testCase stub] andReturn:invocation] invocation];
    [[[(id)testCase stub] andReturn:suiteName] name];
    return [NSNotification notificationWithName:notificationName object:run];
};

NSNotification *(^notificationForTest)(NSString *, INLTest *) = ^(NSString *name, INLTest *test) {
    INLInvocation  *invocation = [INLInvocation invocationWithTest:test];
    SenTestCase    *testCase   = [[INLTestCase alloc] initWithInvocation:invocation];
    SenTestRun     *run        = [[SenTestRun alloc] initWithTest:testCase];
    return [NSNotification notificationWithName:name object:run];
};

NSNotification *(^notificationForFailedTest)(NSString *, INLTest *, NSException *) = ^(NSString *name, INLTest *test, NSException *exception) {
    INLInvocation  *invocation   = [INLInvocation invocationWithTest:test];
    SenTestCase    *testCase     = [[INLTestCase alloc] initWithInvocation:invocation];
    SenTestRun     *run          = [OCMockObject partialMockForObject:[[SenTestRun alloc] initWithTest:testCase]];
    NSDictionary *info = (exception) ? @{@"exception" : exception} : nil;
    [[[(id)run stub] andReturnValue:OCMOCK_VALUE((BOOL){NO})] hasSucceeded];
    return [NSNotification notificationWithName:name object:run userInfo:info];
};

INLTest *(^testWithParents)(NSString *, NSArray *) = ^(NSString *label, NSArray *parents) {
    INLTest *test = [[INLTest alloc] init];
    [test setLabel:label];
    
    id current = test;
    for (id group in [parents reverseObjectEnumerator]) {
        [current setParent:group];
        current = group;
    }
    
    return test;
};

INLGroup *(^groupLabelled)(NSString *) = ^(NSString *label) {
    INLGroup *group = [[INLGroup alloc] init];
    [group setLabel:label];
    return group;
};

__block NSMutableString *output;
__block id               reporter;
__block NSArray         *groups;
__block NSArray         *tests;

before(^{
    output = [NSMutableString string];
    reporter = [OCMockObject partialMockForObject:[INLGroupedReporter new]];
    [[[reporter stub] andCall:@selector(appendString:) onObject:output] log:OCMOCK_ANY];
    groups = @[groupLabelled(@"Group 1"), groupLabelled(@"Group 2")];
    tests = @[testWithParents(@"Test 1", groups), testWithParents(@"Test 2", groups)];
});

void(^itShouldBehaveLikeAPassingSuite)(void(^)(void), NSString *) = ^(void(^run)(void), NSString *prefix) {
    // TODO: Prefix would be unnecessary if we could match against Regex expressions.
    
    it(@"should not indent top level group labels", ^{
        run();
        expect(output).to.contain(@"Group 1\n");
    });
    
    it(@"should indent nested group labels", ^{
        run();
        expect(output).to.contain(@"\tGroup 2\n");
    });
    
    it(@"should indent test labels once more than group labels", ^{
        run();
        expect(output).to.contain(@"\t\tTest 1\n");
        expect(output).to.contain(@"\t\tTest 2\n");
    });
    
    it(@"should arrange tests within the same group under the same group label", ^{
        run();
        NSString *expected = [NSString stringWithFormat:@"%@\t\tTest 1\n%@\t\tTest 2\n", prefix, prefix];
        expect(output).to.contain(expected);
    });
};

when(@"class is initialized", ^{
    it(@"should activate INLGroupedReporter", ^{
        [TSCObserver setActiveReporter:nil];
        [INLGroupedReporter initialize];
        expect([TSCObserver activeReporter]).to.beKindOf([INLGroupedReporter class]);
    });
});

when(@"reporting a passing suite", ^{
    before(^{
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [test setState:INLTestStateReady];
        }];
    });
    
    void(^run)(void) = ^(void) {
        [reporter suiteDidStart:notificationForSuite(SenTestSuiteDidStartNotification, @"Suite")];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:notificationForTest(SenTestCaseDidStartNotification, test)];
            [reporter testDidEnd:notificationForTest(SenTestCaseDidStopNotification, test)];
        }];
        [reporter suiteDidEnd:notificationForSuite(SenTestSuiteDidStopNotification, @"Suite")];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"");
});

when(@"reporting a pending suite", ^{
    void(^run)(void) = ^(void) {
        [reporter suiteDidStart:notificationForSuite(SenTestSuiteDidStartNotification, @"Suite")];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:notificationForTest(SenTestCaseDidStartNotification, test)];
            [reporter testDidEnd:notificationForTest(SenTestCaseDidStopNotification, test)];
        }];
        [reporter suiteDidEnd:notificationForSuite(SenTestSuiteDidStopNotification, @"Suite")];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"[P]");
    
    it(@"should prefix failing tests with [P]", ^{
        run();
        expect(output).to.contain(@"[P]\t\tTest 1\n");
        expect(output).to.contain(@"[P]\t\tTest 2\n");
    });
});

when(@"reporting a failing suite", ^{
    before(^{
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [test setState:INLTestStateReady];
        }];
    });
    
    void(^run)(void) = ^(void) {
        NSException *exception = [NSException exceptionWithName:@"SomeException" reason:@"some reason" userInfo:@{SenTestFilenameKey: @(__FILE__), SenTestLineNumberKey: @(__LINE__)}];
        [reporter suiteDidStart:notificationForSuite(SenTestSuiteDidStartNotification, @"Suite")];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:notificationForTest(SenTestCaseDidStartNotification, test)];
            [reporter testDidFail:notificationForFailedTest(SenTestCaseDidFailNotification, test, exception)];
            [reporter testDidEnd:notificationForFailedTest(SenTestCaseDidStopNotification, test, nil)];
        }];
        [reporter suiteDidEnd:notificationForSuite(SenTestSuiteDidStopNotification, @"Suite")];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"[F]");
    
    it(@"should prefix failing tests with [F]", ^{
        run();
        expect(output).to.contain(@"[F]\t\tTest 1\n");
        expect(output).to.contain(@"[F]\t\tTest 2\n");
    });
});

SpecEnd
