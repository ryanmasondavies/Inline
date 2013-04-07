//
//  INLGroup.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Caboodle/Caboodle.h>
#import "INLNode.h"

/** Represents a group of tests and their hooks. */
@interface INLGroup : NSObject <INLNode>

/** Initializes a group with a set of nodes.
 @param label  A label for the group.
 @param nodes  A sorted array of nodes.
 @param weight The weight for this node, used for ordering the graph.
 @return An initialized group. */
- (id)initWithLabel:(NSString *)label nodes:(CBDSortedArray *)nodes weight:(NSNumber *)weight;

/** The group's label. */
- (NSString *)label;

@end
