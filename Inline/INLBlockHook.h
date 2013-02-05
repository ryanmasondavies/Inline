//
//  INLBlockHook.h
//  Inline
//
//  Created by Ryan Davies on 05/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLHook.h"

/** INLBlockHook allows the implementation of a hook to be specified using a block. */
@interface INLBlockHook : INLHook

/** The block which is invoked on [INLBlockHook execute]. */
@property (copy, nonatomic) void(^block)(void);

/** Executes before and after hooks around the block. */
- (void)execute;

@end
