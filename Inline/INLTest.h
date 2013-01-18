//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Abstract interface for an executable test. */
@interface INLTest : NSObject

/** The name of the test, used for identification. */
@property (copy, nonatomic) NSString *name;

/** The test implementation. */
@property (copy, nonatomic) void(^block)(void);

/** Invokes block. */
- (void)execute;

@end
