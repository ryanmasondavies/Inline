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

@implementation INLGroup

- (id)init
{
    if (self = [super init]) {
        self.groups = @[];
        self.tests  = @[];
        self.hooks  = @[];
    }
    return self;
}

- (void)addGroup:(INLGroup *)group
{
    group.parent = self;
    self.groups = [[self groups] arrayByAddingObject:group];
}

- (void)addTest:(INLTest *)test
{
    test.parent = self;
    self.tests = [[self tests] arrayByAddingObject:test];
}

- (void)addHook:(INLHook *)hook
{
    hook.parent = self;
    self.hooks = [[self hooks] arrayByAddingObject:hook];
}

@end
