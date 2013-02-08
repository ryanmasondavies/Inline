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
    if (block)
        self.state = INLTestStateReady;
    else
        self.state = INLTestStatePending;
}

- (void)execute
{
    if (self.state == INLTestStatePending) return;
    [self executeBeforeHooks];
    self.block();
    [self executeAfterHooks];
    self.state = INLTestStateExecuted;
}

@end
