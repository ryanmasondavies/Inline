//
//  INLBlockTest.m
//  Inline
//
//  Created by Ryan Davies on 04/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLBlockTest.h"
#import "INLNodePath.h"

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
    [self executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self] placement:INLHookPlacementBefore];
    self.block();
    [self executeHooksInNodePath:[INLNodePath nodePathForDestinationNode:self] placement:INLHookPlacementAfter];
    self.state = INLTestStateExecuted;
}

@end
