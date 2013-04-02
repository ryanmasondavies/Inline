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

/** A test in ready state: it has a block to run, and a label to display. */
@interface INLReadyState : NSObject <INLTestState>

/** Initialize a ready state.
 @param block The block to execute when run.
 @param label The label to identify the test.
 */
- (id)initWithBlock:(INLTestBlock)block label:(NSString *)label;

@end
