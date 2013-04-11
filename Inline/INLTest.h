//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLComponent.h"
#import "INLTypes.h"

/** An executable test which raises an exception if any expectations are not met. */
@interface INLTest : NSObject <INLComponent>

/** Initializes a new test.
 @param block The block which defines the test.
 @param weight The weight of the test, for ordering the component graph.
 @return An initialized test. */
- (id)initWithBlock:(INLTestBlock)block weight:(NSNumber *)weight;

/** @return The name for the test. */
- (NSString *)name;

@end
