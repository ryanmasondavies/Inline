//
//  INLGroup.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroup.h"
#import "INLVisitor.h"

@interface INLGroup ()
@property (copy, nonatomic) NSString *label;
@property (strong, nonatomic) NSMutableArray *nodes;
@property (copy, nonatomic) NSNumber *weight;
@end

@implementation INLGroup

- (id)initWithLabel:(NSString *)label nodes:(NSMutableArray *)nodes weight:(NSNumber *)weight
{
    if (self = [super init]) {
        [self setLabel:label];
        [self setNodes:nodes];
        [self setWeight:weight];
    }
    return self;
}

- (void)acceptVisitor:(id<INLVisitor>)visitor
{
    [[self nodes] makeObjectsPerformSelector:@selector(acceptVisitor:) withObject:visitor];
}

- (NSString *)description
{
    return [self label];
}

- (void)addNode:(id<INLNode>)node
{
    [[self nodes] addObject:node];
}

- (void)removeNode:(id<INLNode>)node
{
    [[self nodes] removeObject:node];
}

@end
