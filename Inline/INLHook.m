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
@property (nonatomic) INLHookPlacement placement;
@end

@implementation INLHook

- (id)initWithBlock:(INLHookBlock)block placement:(INLHookPlacement)placement
{
    if (self = [self init]) {
        [self setBlock:block];
        [self setPlacement:placement];
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
