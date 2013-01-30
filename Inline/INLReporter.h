//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
@class INLTest;

/** An interface to which reporters must conform. */
@protocol INLReporter <NSObject>

/** Invoked by INLObserver when a suite has started.
 @param run The current test run. */
- (void)suiteDidStart:(SenTestRun *)run;

/** Invoked by INLObserver when a suite has ended. 
 @param run The current test run. */
- (void)suiteDidEnd:(SenTestRun *)run;

/** Invoked by INLObserver when a test has started.
 @param test The test that has started.
 @param run The current test run. */
- (void)testDidStart:(INLTest *)test run:(SenTestRun *)run;

/** Invoked by INLObserver when a test has failed.
 @param test The test in which an exception has been raised. 
 @param run The current test run. */
- (void)testDidFail:(INLTest *)test run:(SenTestRun *)run;

/** Invoked by INLObserver when a test has ended.
 @param test The test that has ended.
 @param run The current test run. */
- (void)testDidEnd:(INLTest *)test run:(SenTestRun *)run;

@end
