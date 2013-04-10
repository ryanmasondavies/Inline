//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 17/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLDateProvider, INLGroup, INLTest, INLHook;
@protocol INLPublisher;

/** A reporter is notified as a run event propagates through a component hierarchy. */
@interface INLReporter : NSObject

/**
 Initialize a reporter.
 @param dateProvider A necessary abstraction for testing purposes, used to retrieve the current date.
 @param publisher Publishes the report.
 @param report Accumulated as the reporter is notified about events.
 @return An initialized reporter.
 */
- (id)initWithDateProvider:(INLDateProvider *)dateProvider publisher:(id<INLPublisher>)publisher report:(NSMutableDictionary *)report;

/** Invoked by INLRunner when a run has started. */
- (void)runDidStart;

/** Invoked by INLRunner when a run has finished. */
- (void)runDidFinish;

/**
 Invoked by INLGroup when a group is about to run its components.
 @param group The group that has started.
 */
- (void)groupDidStart:(INLGroup *)group;

/**
 Invoked by INLGroup when a group has finished running its components.
 @param group The group that has finished.
 */
- (void)groupDidFinish:(INLGroup *)group;

/**
 Invoked by INLTest when about to run.
 @param test The test that is about to run.
 */
- (void)testDidStart:(INLTest *)test;

/**
 Invoked by INLTest when it has passed.
 @param test The test that has passed.
 @param duration The amount of time it took for the test to pass, in seconds.
 */
- (void)testDidPass:(INLTest *)test withDuration:(NSTimeInterval)duration;

/**
 Invoked by INLTest when it has skipped running.
 @param test The test that has skipped running.
 */
- (void)testDidSkip:(INLTest *)test;

/**
 Invoked by INLTest when it has failed.
 @param test The test that has failed.
 @param exception The exception that caused the test to fail.
 */
- (void)testDidFail:(INLTest *)test withException:(NSException *)exception;

@end
