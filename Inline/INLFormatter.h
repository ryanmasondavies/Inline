//
//  INLFormatter.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLReporter.h"
@class INLGroup, INLTest;

/** A formatter helps a reporter to write a report in a specific format. */
@protocol INLFormatter

/**
 Write to a report that a group started.
 @param group The group that has started.
 @param report The report to be written to.
 */
- (void)writeGroupDidStart:(INLGroup *)group toReport:(NSMutableString *)report;

/**
 Write to a report that a group finished.
 @param group The group that has finished.
 @param report The report to be written to.
 */
- (void)writeGroupDidFinish:(INLGroup *)group toReport:(NSMutableString *)report;

/**
 Write to a report that a test started.
 @param test The test that has started.
 @param report The report to be written to.
 */
- (void)writeTestDidStart:(INLTest *)test toReport:(NSMutableString *)report;

/**
 Write to a report that a test passed.
 @param test The test that has passed.
 @param report The report to be written to.
 */
- (void)writeTestDidPass:(INLTest *)test toReport:(NSMutableString *)report;

/**
 Write to a report that a test skipped.
 @param test The test that has skipped.
 @param report The report to be written to.
 */
- (void)writeTestDidSkip:(INLTest *)test toReport:(NSMutableString *)report;

/**
 Write to a report that a test failed.
 @param test The test that has failed.
 @param exception The exception that caused the test to fail.
 @param report The report to be written to.
 */
- (void)writeTestDidFail:(INLTest *)test withException:(NSException *)exception toReport:(NSMutableString *)report;

@end
