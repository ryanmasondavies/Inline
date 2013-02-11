//
//  INLNodePath.h
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLNode;

/** Defines the path to a node. */
@interface INLNodePath : NSObject

/**
 @param node The destination node.
 @return An initialized node path which points to the destination node.
 */
+ (instancetype)nodePathForDestinationNode:(INLNode *)destinationNode;

/**
 @param node The destination node.
 @return An initialized node path which points to the destination node.
 */
- (instancetype)initWithDestinationNode:(INLNode *)destinationNode;

/** The nodes which point to the destination node. */
@property (nonatomic, readonly) NSArray *nodes;

/** The destination node. */
@property (nonatomic, readonly) INLNode *destinationNode;

@end
