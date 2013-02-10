//
//  INLNode.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup, INLNodePath;

/** The superclass to elements that can appear in a group. */
@interface INLNode : NSObject

/**
 @param parent The parent for the node.
 @return A new node with the given parent. */
- (id)initWithParent:(INLGroup *)parent;

/** @return The groups which lead to the test. */
- (NSArray *)path;

/** @return A path pointing to the node within it's hierarchy. */
- (INLNodePath *)nodePath;

/** The parent group of the node. */
@property (weak, nonatomic) INLGroup *parent;

/** The label by which to identify the node; not applicable to all. */
@property (copy, nonatomic) NSString *label;

@end
