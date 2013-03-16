//
//  INLHook.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"

typedef void(^INLHookBlock)(void);

typedef NS_ENUM(NSInteger, INLHookPlacement) {
    INLHookPlacementBefore,
    INLHookPlacementAfter
};

/** A hook is invoked before or after a test. */
@interface INLHook : INLNode

/** Initializes a hook.
 @param block The block to be invoked on execution.
 @param placement The hook's placement, either before or after.
 @return An initialized hook. */
- (id)initWithBlock:(INLHookBlock)block placement:(INLHookPlacement)placement;

/** Executes block. */
- (void)execute;

@end
