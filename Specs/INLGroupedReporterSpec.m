//
//  INLGroupedReporterSpec.m
//  Inline
//
//  Created by Ryan Davies on 06/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroupedReporter)

NSNotification *(^notificationWithCase)(NSString *, SenTestCase *) = ^(NSString *name, SenTestCase *testCase) {
    SenTestRun *run = [[SenTestRun alloc] initWithTest:testCase];
    return [NSNotification notificationWithName:name object:run];
};

NSNotification *(^notificationForSuite)(NSString *, NSString *) = ^(NSString *notificationName, NSString *suiteName) {
    INLInvocation  *invocation   = [INLInvocation invocationWithTest:nil];
    OCMockObject   *testCase     = [OCMockObject mockForClass:[SenTestCase class]];
    [[[testCase stub] andReturn:invocation] invocation];
    [[[testCase stub] andReturn:suiteName] name];
    return notificationWithCase(notificationName, (SenTestCase *)testCase);
};

NSNotification *(^notificationForTest)(NSString *, INLTest *) = ^(NSString *name, INLTest *test) {
    INLInvocation  *invocation   = [INLInvocation invocationWithTest:test];
    SenTestCase    *testCase     = [[INLTestCase alloc] initWithInvocation:invocation];
    return notificationWithCase(name, testCase);
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
__block id reporter;

before(^{
    output = [NSMutableString string];
    reporter = [OCMockObject partialMockForObject:[INLGroupedReporter new]];
    [[[reporter stub] andCall:@selector(appendString:) onObject:output] log:OCMOCK_ANY];
});

void(^itShouldBehaveLikeAPassingSuite)(void(^)(void)) = ^(void(^run)(void)) {
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
        expect(output).to.contain(@"\t\tTest 1\n\t\tTest 2\n");
    });
};

describe(@"a passing suite", ^{
    void(^run)(void) = ^(void) {
        NSArray *groups = @[groupLabelled(@"Group 1"), groupLabelled(@"Group 2")];
        NSArray *tests = @[testWithParents(@"Test 1", groups), testWithParents(@"Test 2", groups)];
        [reporter suiteDidStart:notificationForSuite(SenTestSuiteDidStartNotification, @"Suite")];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:notificationForTest(SenTestCaseDidStartNotification, test)];
            [reporter testDidEnd:notificationForTest(SenTestCaseDidStopNotification, test)];
        }];
        [reporter suiteDidEnd:notificationForSuite(SenTestSuiteDidStopNotification, @"Suite")];
    };
    
    itShouldBehaveLikeAPassingSuite(run);
});

// TODO: Write specs
//describe(@"a pending suite", ^{
//    void(^run)(void) = ^(void) {};
//    itShouldBehaveLikeAPassingSuite(run);
//    
//    it(@"should prefix failing tests with [P]", ^{});
//});
//
//describe(@"a failing suite", ^{
//    void(^run)(void) = ^(void) {};
//    itShouldBehaveLikeAPassingSuite(run);
//    
//    it(@"should prefix failing tests with [F]", ^{});
//});

SpecEnd
