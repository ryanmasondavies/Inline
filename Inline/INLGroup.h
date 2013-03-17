//
//  INLGroup.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLNode.h"

/** Represents a group of tests and their hooks. */
@interface INLGroup : NSObject <INLNode>

/** Initializes a group with a set of nodes.
 @param label A label for the group.
 @param nodes A mutable array of nodes.
 @return An initialized group. */
- (id)initWithLabel:(NSString *)label nodes:(NSMutableArray *)nodes;

/** @return The group's label. */
- (NSString *)description;

/** Adds a node to the group.
 @param node The node to add. */
- (void)addNode:(id <INLNode>)node;

/** Remove a node.
 @param node The node to remove. */
- (void)removeNode:(id <INLNode>)node;

@end
