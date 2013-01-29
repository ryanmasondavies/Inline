//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Represents a test within the system. */
@interface INLTest : NSObject

/** The parent group which the test is a child of. */
@property (weak, nonatomic) INLGroup *parent;

/** A label by which to identify the test, if any. */
@property (copy, nonatomic) NSString *label;

/** Runs the test. Must be overridden by subclasses. It is advised that subclasses invoke executeBeforeHooks and executeAfterHooks around execution of the test itself. */
- (void)execute;

/** Invokes [INLHook execute] on all hooks with a placement of 'before' in outermost-first order. */
- (void)executeBeforeHooks;

/** Invokes [INLHook execute] on all hooks with a placement of 'after' in innermost-first order. */
- (void)executeAfterHooks;

@end
