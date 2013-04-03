//
//  INLSuite.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Each subclass creates tests and adds them to a group. */
@interface INLSuite : NSObject

/**
 Add nodes to the group. Used to gather nodes for running.
 @param group The group to which nodes must be added.
 */
- (void)addNodesToGroup:(INLGroup *)group;

@end
