//
//  INLHook.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
@class INLGroup;

typedef NS_ENUM(NSInteger, INLHookPlacement) {
    INLHookPlacementBefore,
    INLHookPlacementAfter
};

/** Superclass for hooks of varying scope. */
@interface INLHook : INLNode

/** The placement of the hook: either INLTestPlacementBefore or INLTestPlacementAfter. This defines whether the hook is to be executed before or after tests. */
@property (nonatomic) INLHookPlacement placement;

/** Executes the hook. */
- (void)execute;

@end
