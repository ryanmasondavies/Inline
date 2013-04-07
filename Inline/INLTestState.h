//
//  INLTestState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTest;

/** A state in which a test can be in: pending, ready, passed, failed. */
@protocol INLTestState <NSObject>

/** The name for the test's state. */
- (NSString *)name;

/**
 Run the test. Applicable only to the ready state.
 @param test The test requesting the run.
 */
- (void)runForTest:(INLTest *)test;

/**
 Set the failure reason. Applicable only the failed state.
 @param reason The reason for failure.
 */
- (void)setReason:(NSString *)reason;

@end
