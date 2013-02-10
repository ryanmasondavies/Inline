//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
#import "INLHook.h"
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

/** Executes all hooks – with the given placement – attached to each group in the given node path.
 @param nodePath The path for which to execute hooks.
 @param placement The placement by which to filter hooks.
 */
- (void)executeHooksInNodePath:(INLNodePath *)nodePath placement:(INLHookPlacement)placement;

/** The states a test can be in.
 
 The possible values are:
 
 - INLTestStatePending
 - INLTestStateReady
 - INLTestStateExecuted
 */
@property (nonatomic) INLTestState state;

@end
