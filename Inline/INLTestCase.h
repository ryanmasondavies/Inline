//
//  INLTestCase.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class INLTestInvocation;

/** Extends SenTestCase to allow developers to add and remove test invocations, rather than generating them from void methods prefixed with `test` with no arguments. This class is abstract and so is intended to be subclassed. Class methods performed on a subclass apply only to that subclass, and not to the superclass or siblings. */
@interface INLTestCase : SenTestCase

/** Adds a test invocation to the list. Invocations added to one subclass are not available in another.
 @param testInvocation The invocation to add. */
+ (void)addTestInvocation:(INLTestInvocation *)testInvocation;

/** Removes a test invocation from the list. Invocations removed from one subclass remain available in others. 
 @param testInvocation The invocation to remove. */
+ (void)removeTestInvocation:(INLTestInvocation *)testInvocation;

/** @return Returns an immutable list of the invocations added, in the order in which they were added. */
+ (NSArray *)testInvocations;

/** @return The name of the current test. */
- (NSString *)name;

@end
