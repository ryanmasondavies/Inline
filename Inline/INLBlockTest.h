//
//  INLBlockTest.h
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"

/** INLBlockTest encapsulates the concept of specifying a test using a block. This technique is commonly required by DSL's such as in Specify and Stories. */
@interface INLBlockTest : INLTest

/** The block which performs the test. */
@property (copy, nonatomic) void(^block)(void);

@end
