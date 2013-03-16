//
//  INLStack.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** A stack is used to handle nesting groups during the construction process. */
@interface INLStack : NSObject

/** Initialize a new stack.
 @param groups The array which groups are pushed to and popped from.
 @return An initialized instance of INLStack. */
- (id)initWithGroups:(NSMutableArray *)groups;

/** Pushes a new group to the array.
 @param group The group to be added. */
- (void)pushGroup:(INLGroup *)group;

/** Pops a group from the stack. 
 @return The popped stack. */
- (INLGroup *)popGroup;

@end
