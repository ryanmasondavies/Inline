//
//  INLHook.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLHook.h"
#import "INLVisitor.h"

@interface INLHook ()
@property (copy, nonatomic) INLHookBlock block;
@property (copy, nonatomic) NSNumber *weight;
@end

@implementation INLHook

- (id)initWithBlock:(INLHookBlock)block weight:(NSNumber *)weight
{
    if (self = [self init]) {
        [self setBlock:block];
        [self setWeight:weight];
    }
    return self;
}

- (void)acceptVisitor:(id<INLVisitor>)visitor
{
    [visitor visitHook:self];
}

- (void)run
{
    [self block]();
}

@end
