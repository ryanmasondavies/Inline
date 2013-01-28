//
//  INLCompiler.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Defines an implementation for objects which are responsible for compiling tests into a set of invocations for use by INLTestCase. The order of the array is maintained when running the tests. */
@protocol INLCompiler <NSObject>

/**
 This method should be implemented by different DSLs to create invocations for tests. By default it creates invocations by placing those in subgroups at the bottom of the stack.
 @param group The group for which to compile tests.
 @return An immutable list of invocations for each test in the group. */
- (NSArray *)invocationsForGroup:(INLGroup *)group;

@end
