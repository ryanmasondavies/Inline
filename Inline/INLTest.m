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

- (NSArray *)hooksInNodePath:(INLNodePath *)nodePath placement:(INLHookPlacement)placement
{
    NSMutableArray *hooks = [NSMutableArray array];
    [[nodePath nodes] enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger i, BOOL *stop) {
        [[group hooks] enumerateObjectsUsingBlock:^(INLHook *hook, NSUInteger idx, BOOL *stop) {
            if ([hook placement] == placement) {
                [hooks addObject:hook];
            }
        }];
    }];
    return [NSArray arrayWithArray:hooks];
}

- (NSEnumerator *)enumeratorForHooks:(NSArray *)hooks placement:(INLHookPlacement)placement
{
    if (placement == INLHookPlacementBefore) return [hooks objectEnumerator];
    if (placement == INLHookPlacementAfter)  return [hooks reverseObjectEnumerator];
    return nil;
}

- (void)executeHooksInNodePath:(INLNodePath *)nodePath placement:(INLHookPlacement)placement
{
    NSAssert(nodePath, @"Must pass in a node path.");
    NSArray *hooks = [self hooksInNodePath:nodePath placement:placement];
    for (INLHook *hook in [self enumeratorForHooks:hooks placement:placement]) {
        [hook execute];
    }
}

@end
