//
//  INLGroup.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroup.h"
#import "INLTest.h"
#import "INLHook.h"

@interface INLGroup ()
@property (strong, nonatomic) NSMutableArray *nodes;
@end

@implementation INLGroup

- (id)init
{
    if (self = [super init]) {
        self.nodes  = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)nodesOfKind:(Class)kind
{
    NSAssert(kind, @"Must be passed a class.");
    
    NSMutableArray *nodes = [NSMutableArray array];
    [[self nodes] enumerateObjectsUsingBlock:^(id <INLNode> node, NSUInteger idx, BOOL *stop) {
        if ([node isKindOfClass:kind]) {
            [nodes addObject:node];
        }
    }];
    
    return [NSArray arrayWithArray:nodes];
}

- (void)addNode:(id <INLNode>)node
{
    NSAssert(node, @"Must be passed a node.");
    [[self nodes] addObject:node];
}

- (void)removeNode:(id <INLNode>)node
{
    NSAssert(node, @"Must be passed a node.");
    [[self nodes] removeObject:node];
}

- (NSArray *)groups
{
    return [self nodesOfKind:[INLGroup class]];
}

- (NSArray *)tests
{
    return [self nodesOfKind:[INLTest class]];
}

- (NSArray *)hooks
{
    return [self nodesOfKind:[INLHook class]];
}

@end
