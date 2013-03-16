//
//  INLTest.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"

@interface INLTest ()
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) INLTestBlock block;
@end

@implementation INLTest

- (id)initWithLabel:(NSString *)label block:(INLTestBlock)block
{
    if (self = [self init]) {
        [self setLabel:label];
        [self setBlock:block];
    }
    return self;
}

- (void)execute
{
    [self block]();
}

@end
