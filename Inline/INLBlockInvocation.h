//
//  INLBlockInvocation.h
//  Inline
//
//  Created by Ryan Davies on 12/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLTypes.h"

/** An invocations that executes a block. */
@interface INLBlockInvocation : NSInvocation

/**
 Initialize a block invocation.
 @param block The block to be executed when -invoke is called.
 @return An initialized block invocation.
 */
+ (id)invocationWithBlock:(INLVoidBlock)block;

@end
