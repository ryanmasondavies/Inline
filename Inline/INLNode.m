//
//  INLNode.m
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
#import "INLGroup.h"
#import "INLNodePath.h"

@implementation INLNode

- (id)initWithParent:(INLGroup *)parent
{
    if (self = [self init]) {
        self.parent = parent;
    }
    return self;
}

- (NSArray *)path
{
    if ([self parent] == nil) return @[];
    NSArray *path = [NSArray array];
    path = [path arrayByAddingObjectsFromArray:[[self parent] path]];
    path = [path arrayByAddingObject:[self parent]];
    return path;
}

- (INLNodePath *)nodePath
{
    return [[INLNodePath alloc] initWithDestinationNode:self];
}

@end
