//
//  INLNodePath.h
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Defines the path to a node. */
@interface INLNodePath : NSObject

/** Initialize a new node path.
 @param groups The groups which make up the path. 
 @return An initialized node. */
- (id)initWithGroups:(NSArray *)groups;

@end
