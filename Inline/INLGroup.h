//
//  INLGroup.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Caboodle/Caboodle.h>
#import "INLComponent.h"

/** Represents a group of tests and their hooks. */
@interface INLGroup : NSObject <INLComponent>

/** Initializes a group with a set of components.
 @param name  A name for the group.
 @param components  A sorted array of components.
 @param weight The weight for this component, used for ordering the graph.
 @return An initialized group. */
- (id)initWithName:(NSString *)name components:(CBDSortedArray *)components weight:(NSNumber *)weight;

/** @return The group's name. */
- (NSString *)name;

@end
