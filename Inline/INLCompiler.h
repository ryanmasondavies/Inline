//
//  INLCompiler.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Defines an implementation for objects which are responsible for compiling tests into a set of invocations for use by INLTestCase. The order of the array is maintained when running the tests. */
@protocol INLCompiler <NSObject>

/**
 This method should be implemented by different DSLs to create invocations for tests. This can become complicated in for some, e.g when implementing a BDD testing library, as test groups will need to be taken into consideration.
 @param tests The tests to be executed.
 @return An immutable list of invocations which execute the tests. */
- (NSArray *)invocationsForTests:(NSArray *)tests;

@end
