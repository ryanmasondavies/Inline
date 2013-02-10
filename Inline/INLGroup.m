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

- (NSArray *)nodesOfKind:(Class)klass
{
    NSMutableArray *nodes = [NSMutableArray array];
    [[self nodes] enumerateObjectsUsingBlock:^(INLNode *node, NSUInteger idx, BOOL *stop) {
        if ([node isKindOfClass:klass]) {
            [nodes addObject:node];
        }
    }];
    return [NSArray arrayWithArray:nodes];
}

- (void)addNode:(INLNode *)node
{
    [[self nodes] addObject:node];
    [node setParent:self];
}

- (void)removeNode:(INLNode *)node
{
    [[self nodes] removeObject:node];
    [node setParent:nil];
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
