//
//  INLHook.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLNode.h"
@class INLGroup;

typedef NS_ENUM(NSInteger, INLHookPlacement) {
    INLHookPlacementBefore,
    INLHookPlacementAfter
};

/** Abstract superclass for hooks of varying scope. */
@interface INLHook : NSObject <INLNode>

/** The group which the hook has been added to. */
@property (weak, nonatomic) INLGroup *parent;

/** The placement of the hook: either INLTestPlacementBefore or INLTestPlacementAfter. This defines whether the hook is to be executed before or after tests. */
@property (nonatomic) INLHookPlacement placement;

/** Executes the hook. */
- (void)execute;

@end
