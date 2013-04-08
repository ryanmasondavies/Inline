//
//  INLTestState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLReporter;
@class INLTest;

/** A state in which a test can be in: pending, ready, passed, failed. */
@protocol INLTestState <NSObject>

/** The name for the test's state. */
- (NSString *)name;

/**
 Run the test. Applicable only to the ready state.
 @param reporter The reporter to notify.
 @param test The test requesting the run.
 */
- (void)runWithReporter:(id<INLReporter>)reporter forTest:(INLTest *)test;

@end
