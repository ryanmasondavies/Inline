//
//  INLTest.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"
#import "INLNodePath.h"
#import "INLGroup.h"
#import "INLHook.h"

@implementation INLTest

- (void)execute
{
}

- (NSArray *)hooks
{
    NSMutableArray *hooks = [NSMutableArray array];
    [[[self nodePath] nodes] enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger i, BOOL *stop) {
        [hooks addObjectsFromArray:[group hooks]];
    }];
    return [NSArray arrayWithArray:hooks];
}

- (void)executeHooks:(NSArray *)hooks withPlacement:(INLHookPlacement)placement usingEnumerator:(NSEnumerator *)enumerator
{
    for (INLHook *hook in enumerator) {
        if ([hook placement] == placement) {
            [hook execute];
        }
    }
}

- (void)executeBeforeHooks
{
    [self executeHooks:[self hooks] withPlacement:INLHookPlacementBefore usingEnumerator:[[self hooks] objectEnumerator]];
}

- (void)executeAfterHooks
{
    [self executeHooks:[self hooks] withPlacement:INLHookPlacementAfter usingEnumerator:[[self hooks] reverseObjectEnumerator]];
}

@end
