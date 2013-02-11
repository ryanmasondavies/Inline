//
//  INLGroupedReporterSpec.m
//  Inline
//
//  Created by Ryan Davies on 06/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLGroupedReporter)

__block NSMutableString *output;
__block id               reporter;
__block NSArray         *groups;
__block NSArray         *tests;

before(^{
    output = [NSMutableString string];
    reporter = [OCMockObject partialMockForObject:[INLGroupedReporter new]];
    [[[reporter stub] andCall:@selector(appendString:) onObject:output] log:OCMOCK_ANY];
    groups = @[[INLGroupFactory createGroupLabelled:@"Group 1"], [INLGroupFactory createGroupLabelled:@"Group 2"]];
    tests = @[[INLTestFactory createTestLabelled:@"Test 1" withParents:groups], [INLTestFactory createTestLabelled:@"Test 2" withParents:groups]];
});

void(^itShouldBehaveLikeAPassingSuite)(void(^)(void), NSString *) = ^(void(^run)(void), NSString *prefix) {
    // TODO: Prefix would be unnecessary if we could match against Regex expressions.
    
    it(@"does not indent top level group labels", ^{
        run();
        expect(output).to.contain(@"Group 1\n");
    });
    
    it(@"does indent nested group labels", ^{
        run();
        expect(output).to.contain(@"\tGroup 2\n");
    });
    
    it(@"indents test labels once more than group labels", ^{
        run();
        expect(output).to.contain(@"\t\tTest 1\n");
        expect(output).to.contain(@"\t\tTest 2\n");
    });
    
    it(@"arranges tests within the same group under the same group label", ^{
        run();
        NSString *expected = [NSString stringWithFormat:@"%@\t\tTest 1\n%@\t\tTest 2\n", prefix, prefix];
        expect(output).to.contain(expected);
    });
};

when(@"class is initialized", ^{
    it(@"activates INLGroupedReporter", ^{
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
        [reporter suiteDidStart:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStartNotification forSuiteNamed:@"Suite"]];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStartNotification forTest:test]];
            [reporter testDidEnd:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStopNotification forTest:test]];
        }];
        [reporter suiteDidEnd:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStopNotification forSuiteNamed:@"Suite"]];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"");
});

when(@"reporting a pending suite", ^{
    void(^run)(void) = ^(void) {
        [reporter suiteDidStart:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStartNotification forSuiteNamed:@"Suite"]];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStartNotification forTest:test]];
            [reporter testDidEnd:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStopNotification forTest:test]];
        }];
        [reporter suiteDidEnd:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStopNotification forSuiteNamed:@"Suite"]];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"[P]");
    
    it(@"prefixes failing tests with [P]", ^{
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
    
    __block NSException *exception;
    
    void(^run)(void) = ^(void) {
        exception = [NSException exceptionWithName:@"SomeException" reason:@"some reason" userInfo:@{SenTestFilenameKey: @(__FILE__), SenTestLineNumberKey: @100}];
        [reporter suiteDidStart:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStartNotification forSuiteNamed:@"Suite"]];
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            [reporter testDidStart:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStartNotification forTest:test]];
            [reporter testDidFail:[INLNotificationFactory createNotificationNamed:SenTestCaseDidFailNotification forTest:test thatFailsWithException:exception]];
            [reporter testDidEnd:[INLNotificationFactory createNotificationNamed:SenTestCaseDidStopNotification forTest:test thatFailsWithException:nil]];
        }];
        [reporter suiteDidEnd:[INLNotificationFactory createNotificationNamed:SenTestSuiteDidStopNotification forSuiteNamed:@"Suite"]];
    };
    
    itShouldBehaveLikeAPassingSuite(run, @"[F]");
    
    it(@"prefixes failing tests with [F]", ^{
        run();
        expect(output).to.contain(@"[F]\t\tTest 1\n");
        expect(output).to.contain(@"[F]\t\tTest 2\n");
    });
    
    it(@"lists exception details under test headings", ^{
        run();
        [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
            NSString *result = [NSString stringWithFormat:@"[F] %@\n\t%@:100: some reason", test, @(__FILE__)];
            expect(output).to.contain(result);
        }];
    });
});

SpecEnd
