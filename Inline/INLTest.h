//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"

typedef void(^INLTestBlock)(void);

/** An executable test which raises an exception is any expectations are not met. */
@interface INLTest : INLNode

/** Initializes a new test.
 @param label The label for the test.
 @param block The block to invoke on execution.
 @param parentGroup The group in which the test exists.
 @return An initialized test. */
- (id)initWithLabel:(NSString *)label block:(INLTestBlock)block;

/** Executes block. */
- (void)execute;

@end
