//
//  INLTestCase.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@protocol INLTestBuilder, INLTestCompiler;
@class INLTestInvocation;

/** Extends SenTestCase to allow developers to use objects which conform to INLTestBuilder to create tests, and use objects which conform to INLTestCompiler to create invocations for them. This class is abstract and is intended to be subclassed. Class methods performed on a subclass apply only to that subclass, and not to the superclass or siblings. */
@interface INLTestCase : SenTestCase

/** Returns the builder assigned to the current class. */
+ (id<INLTestBuilder>)builder;

/** Assigns a builder to the current class. 
 @param builder The builder to assign. Must conform to INLTestBuilder. */
+ (void)setBuilder:(id<INLTestBuilder>)builder;

/** Returns the compiler assigned to the current class. */
+ (id<INLTestCompiler>)compiler;

/** Assigns a compiler to the current class.
 @param compiler The compiler to assign. Must conform to INLTestCompiler. */
+ (void)setCompiler:(id<INLTestCompiler>)compiler;

/** @return Returns an immutable list of the invocations added, in the order in which they were added. */
+ (NSArray *)testInvocations;

/** @return The name of the current test. */
- (NSString *)name;

@end
