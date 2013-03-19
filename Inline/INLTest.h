//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLNode.h"

typedef void(^INLTestBlock)(void);

/** An executable test which raises an exception is any expectations are not met. */
@interface INLTest : NSObject <INLNode>

/** Initializes a new test.
 @param block  The block to invoke on execution.
 @param label  The label for the test.
 @param weight The weight of the test, for ordering the node graph.
 @param parentGroup The group in which the test exists.
 @return An initialized test. */
- (id)initWithBlock:(INLTestBlock)block label:(NSString *)label weight:(NSNumber *)weight;

/** Executes block. */
- (void)run;

@end
