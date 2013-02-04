//
//  INLBlockTest.m
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLBlockTest.h"

@implementation INLBlockTest

- (void)setBlock:(void (^)(void))block
{
    _block = block;
    self.state = INLTestStateReady;
}

- (void)execute
{
    if (self.block == nil) return;
    [self executeBeforeHooks];
    self.block();
    [self executeAfterHooks];
    self.state = INLTestStateExecuted;
}

@end
