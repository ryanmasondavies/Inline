//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLNode.h"
@class INLGroup;

typedef NS_ENUM(NSInteger, INLTestState) {
    INLTestStatePending,
    INLTestStateReady,
    INLTestStateExecuted
};

/** Represents a test within the system. */
@interface INLTest : NSObject <INLNode>

/**
 @param parent The parent for the test.
 @return A new test with the given parent. */
- (id)initWithParent:(INLGroup *)parent;

/** @return The groups which lead to the test. */
- (NSArray *)path;

/** Runs the test. Must be overridden by subclasses. It is advised that subclasses invoke executeBeforeHooks and executeAfterHooks around execution of the test itself. */
- (void)execute;

/** Invokes [INLHook execute] on all hooks with a placement of 'before' in outermost-first order. */
- (void)executeBeforeHooks;

/** Invokes [INLHook execute] on all hooks with a placement of 'after' in innermost-first order. */
- (void)executeAfterHooks;

/** The parent group which the test is a child of. */
@property (weak, nonatomic) INLGroup *parent;

/** A label by which to identify the test. */
@property (copy, nonatomic) NSString *label;

/** The states a test can be in.
 
 The possible values are:
 
 - INLTestStatePending
 - INLTestStateReady
 - INLTestStateExecuted
 */
@property (nonatomic) INLTestState state;

@end
