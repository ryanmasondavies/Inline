//
//  INLBlockTest.h
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"

/** INLBlockTest allows the implementation of a test to be defined using a block. */
@interface INLBlockTest : INLTest

/** The block which is invoked on [INLBlockTest execute]. */
@property (copy, nonatomic) void(^block)(void);

/** Executes the block. */
- (void)execute;

@end
