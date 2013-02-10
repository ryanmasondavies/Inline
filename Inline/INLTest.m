//
//  INLTest.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"
#import "INLGroup.h"
#import "INLHook.h"

@implementation INLTest

- (void)execute
{
}

- (NSArray *)hooks
{
    NSMutableArray *hooks = [NSMutableArray array];
    [[self path] enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger i, BOOL *stop) {
        [hooks addObjectsFromArray:[group hooks]];
    }];
    return [NSArray arrayWithArray:hooks];
}

- (void)executeBeforeHooks
{
    // Execute all hooks with a placement of 'before' in forward order:
    for (INLHook *hook in [[self hooks] objectEnumerator]) {
        if ([hook placement] == INLHookPlacementBefore) {
            [hook execute];
        }
    }
}

- (void)executeAfterHooks
{
    // Execute all hooks with a placement of 'after' in reverse order:
    for (INLHook *hook in [[self hooks] reverseObjectEnumerator]) {
        if ([hook placement] == INLHookPlacementAfter) {
            [hook execute];
        }
    }
}

@end
