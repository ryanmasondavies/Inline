//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
@class INLGroup;

typedef NS_ENUM(NSInteger, INLTestState) {
    INLTestStatePending,
    INLTestStateReady,
    INLTestStateExecuted
};

/** Represents a test within the system. */
@interface INLTest : INLNode

/** Runs the test. Must be overridden by subclasses. It is advised that subclasses invoke executeBeforeHooks and executeAfterHooks around execution of the test itself. */
- (void)execute;

/** Invokes [INLHook execute] on all hooks with a placement of 'before' in outermost-first order. */
- (void)executeBeforeHooks;

/** Invokes [INLHook execute] on all hooks with a placement of 'after' in innermost-first order. */
- (void)executeAfterHooks;

/** The states a test can be in.
 
 The possible values are:
 
 - INLTestStatePending
 - INLTestStateReady
 - INLTestStateExecuted
 */
@property (nonatomic) INLTestState state;

@end
