//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Represents a test within the system. */
@interface INLTest : NSObject

/** The parent group which the test is a child of. */
@property (weak, nonatomic) INLGroup *parent;

/** Runs the test. Must be overridden by subclasses. */
- (void)execute;

@end
