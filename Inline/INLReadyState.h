//
//  INLReadyState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLTestState.h"
#import "INLTypes.h"
@class INLPassedState, INLFailedState;

/** A test in ready state: it has a block to run, and a label to display. */
@interface INLReadyState : NSObject <INLTestState>

/**
 Initialize a ready state.
 @param label The label to identify the test.
 @param block The block to execute when run.
 @param passedState The passed state of the test, transitioned to if the block runs without issue.
 @param failedState The failed state of the test, transitioned to if the block raises an exception.
 @return An initialized ready state.
 */
- (id)initWithLabel:(NSString *)label block:(INLTestBlock)block passedState:(INLPassedState *)passedState failedState:(INLFailedState *)failedState;

@end
