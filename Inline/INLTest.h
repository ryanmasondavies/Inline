//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLComponent.h"
@protocol INLTestState;

/** An executable test which raises an exception if any expectations are not met. */
@interface INLTest : NSObject <INLComponent>

/** Initializes a new test.
 @param activeState The active state of the test.
 @param weight The weight of the test, for ordering the component graph.
 @return An initialized test. */
- (id)initWithState:(id<INLTestState>)state weight:(NSNumber *)weight;

/**
 Change the state of the test.
 @param state The new state for the test.
 */
- (void)transitionToState:(id<INLTestState>)state;

/** @return The name for the test. */
- (NSString *)name;

@end
