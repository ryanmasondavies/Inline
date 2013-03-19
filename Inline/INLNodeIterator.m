//
//  INLNodeIterator.m
//  Inline
//
//  Created by Ryan Davies on 19/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNodeIterator.h"

@interface INLNodeIterator ()
@property (strong, nonatomic) NSMutableArray *nodes;
@end

@implementation INLNodeIterator

- (id)initWithNodes:(NSMutableArray *)nodes
{
    if (self = [self init]) {
        [self setNodes:nodes];
    }
    return self;
}

- (id)first
{
    return [[self nodes] objectAtIndex:1];
}

- (id)next
{
    return nil;
}

@end
