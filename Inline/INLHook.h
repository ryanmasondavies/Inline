//
//  INLHook.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLComponent.h"

typedef void(^INLHookBlock)(void);

/** A hook is invoked before or after a test. */
@interface INLHook : NSObject <INLComponent>

/** Initializes a hook.
 @param block The block to be invoked on execution.
 @param weight The weight for the component, used for ordering within the graph.
 @return An initialized hook. */
- (id)initWithBlock:(INLHookBlock)block weight:(NSNumber *)weight;

@end
