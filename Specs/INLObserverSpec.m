//
//  INLObserverSpec.m
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLObserver)

__block id reporter;
__block id notification;
__block id run;
__block id testCase;
__block id invocation;
__block id test;

before(^{
    reporter = [OCMockObject mockForProtocol:@protocol(INLReporter)];
    notification = [OCMockObject mockForClass:[NSNotification class]];
    run = [OCMockObject mockForClass:[SenTestRun class]];
    testCase = [OCMockObject mockForClass:[SenTestCase class]];
    invocation = [OCMockObject mockForClass:[INLInvocation class]];
    test = [OCMockObject mockForClass:[INLTest class]];
    
    [(NSNotification *)[[notification stub] andReturn:run] run];
    [[[run stub] andReturn:testCase] test];
    [[[testCase stub] andReturn:invocation] invocation];
    [[[invocation stub] andReturn:test] test];
    
    [INLObserver setActiveReporter:reporter];
});

describe(@"+testSuiteDidStart:", ^{
    it(@"should forward to active reporter's -suiteDidStart:", ^{
        [[reporter expect] suiteDidStart:run];
        [INLObserver testSuiteDidStart:notification];
        [reporter verify];
    });
});

describe(@"+testStepDidStart:", ^{
    it(@"should forward to active reporter's -testDidStart:run:", ^{
        [[reporter expect] testDidStart:test run:run];
        [INLObserver testCaseDidStart:notification];
        [reporter verify];
    });
});

describe(@"+testStepDidFail:", ^{
    it(@"should forward to active reporter's -testDidFail:run:", ^{
        [[reporter expect] testDidFail:test run:run];
        [INLObserver testCaseDidFail:notification];
        [reporter verify];
    });
});

describe(@"+testStepDidStop:", ^{
    it(@"should forward to active reporter's -testDidEnd:run:", ^{
        [[reporter expect] testDidEnd:test run:run];
        [INLObserver testCaseDidStop:notification];
        [reporter verify];
    });
});

describe(@"+testSuiteDidStop:", ^{
    it(@"should forward to active reporter's -suiteDidEnd:", ^{
        [[reporter expect] suiteDidEnd:run];
        [INLObserver testSuiteDidStop:notification];
        [reporter verify];
    });
});

SpecEnd
