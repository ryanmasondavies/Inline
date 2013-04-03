//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLNode.h"
@protocol INLTestState;

/** An executable test which raises an exception if any expectations are not met. */
@interface INLTest : NSObject <INLNode>

/** Initializes a new test.
 @param activeState The active state of the test.
 @param weight The weight of the test, for ordering the node graph.
 @return An initialized test. */
- (id)initWithState:(id<INLTestState>)state weight:(NSNumber *)weight;

/** Change the state of the test. */
- (void)transitionToState:(id<INLTestState>)state;

/** Executes block. */
- (void)run;

/** Test description. */
- (NSString *)description;

@end
