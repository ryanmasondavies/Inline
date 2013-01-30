//
//  INLObserverSpec.m
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLObserver)

describe(@"+testSuiteDidStart:", ^{
    it(@"should forward to active reporter's -suiteDidStart:", ^{
        id reporter = [OCMockObject mockForProtocol:@protocol(INLReporter)];
        id notification = [OCMockObject mockForClass:[NSNotification class]];
        id run = [OCMockObject mockForClass:[SenTestRun class]];
        
        [[[notification stub] andReturn:run] run];
        
        [INLObserver setActiveReporter:reporter];
        
    });
});

describe(@"+testStepDidStart:", ^{
    it(@"should forward to active reporter's -testDidStart:run:", ^{
    });
});

describe(@"+testStepDidFail:", ^{
    it(@"should forward to active reporter's -testDidFail:run:", ^{
    });
});

describe(@"+testStepDidStop:", ^{
    it(@"should forward to active reporter's -testDidEnd:run:", ^{
    });
});

describe(@"+testSuiteDidStop:", ^{
    it(@"should forward to active reporter's -suiteDidEnd:", ^{
    });
});

SpecEnd
