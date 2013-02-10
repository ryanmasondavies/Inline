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

- (id)initWithParent:(INLGroup *)parent
{
    if (self = [super init]) {
        self.parent = parent;
    }
    return self;
}

- (NSArray *)pathForGroup:(INLGroup *)group
{
    if (group == nil) return @[];
    NSArray *path = [NSArray array];
    path = [path arrayByAddingObjectsFromArray:[self pathForGroup:[group parent]]];
    path = [path arrayByAddingObject:group];
    return path;
}

- (NSArray *)path
{
    return [self pathForGroup:[self parent]];
}

- (void)execute
{
}

- (NSArray *)hooks
{
    // Accumulate hooks by working up the chain:
    INLGroup *group = [self parent];
    NSMutableArray *hooks  = [NSMutableArray array];
    while (group != nil) {
        // Because we're working our way out from the example, hooks must be inserted at the front of the array:
        [hooks insertObjects:[group hooks] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [[group hooks] count])]];
        
        // Move to group's parent:
        group = [group parent];
    }
    
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
