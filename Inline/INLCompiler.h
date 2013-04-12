//
//  INLCompiler.h
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup, INLHook, INLTest;

/** A compiler takes a tree hierarchy of groups, hooks, and tests, and compiles them down into a different format e.g invocations. */
@protocol INLCompiler <NSObject>

/**
 @param group The group that is about to forward the compiler to its components.
 */
- (void)willCompileComponentsOfGroup:(INLGroup *)group;

/**
 @param group The group that has forwarded the compiler to its components.
 */
- (void)didCompileComponentsOfGroup:(INLGroup *)group;

/**
 @param hook The hook to compile.
 */
- (void)compileHook:(INLHook *)hook;

/**
 @param test The test to compile.
 */
- (void)compileTest:(INLTest *)test;

@end
