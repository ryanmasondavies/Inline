//
//  INLTestInvocation.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLTest;

/** A subclass of NSInvocation which calls [INLTest execute] on test rather than invoking a selector, necessary due to the fact that SenTestCase reassigns an invocation's target. */
@interface INLTestInvocation : NSInvocation

/** Creates an INLTestInvocation instance with the given test.
 @param test The test to assign to the INLTestInvocation instance.
 @return A new instance of INLTestInvocation. */
+ (instancetype)invocationWithTest:(id<INLTest>)test;

/** Calls [INLTest execute] on test. */
- (void)invoke;

/** The test assigned to the invocation, which will be executed upon invoke. */
@property (strong, nonatomic) id <INLTest> test;

@end
