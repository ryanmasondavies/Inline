//
//  INLTest.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"
#import "INLResponder.h"

@interface INLTest ()
@property (copy, nonatomic) INLTestBlock block;
@property (copy, nonatomic) NSNumber    *weight;
@end

@implementation INLTest

- (id)initWithBlock:(INLTestBlock)block weight:(NSNumber *)weight
{
    if (self = [self init]) {
        [self setBlock:block];
        [self setWeight:weight];
    }
    return self;
}

- (void)runWithResponder:(id<INLResponder>)responder
{
}

@end
