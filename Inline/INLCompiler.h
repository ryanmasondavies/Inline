//
//  INLCompiler.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** INLCompiler is responsible for compiling tests in a group into a set of invocations for use by INLTestCase. */
@interface INLCompiler : NSObject

/** Creates an instance of INLInvocation for each test in the group, pushing invocations in subgroups to the end of the list.
 @param group The group for which to compile tests.
 @return An immutable list of invocations for each test in the group and subgroups. */
- (NSArray *)invocationsForGroup:(INLGroup *)group;

@end
