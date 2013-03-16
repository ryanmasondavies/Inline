//
//  INLBuilder.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLStack.h"
#import "INLGroup.h"

@interface INLStack ()
@property (strong, nonatomic) NSMutableArray *groups;
@end

@implementation INLStack

- (id)initWithGroups:(NSMutableArray *)groups
{
    if (self = [super init]) {
        self.groups = groups;
    }
    return self;
}

- (void)pushGroup:(INLGroup *)group
{
    [[self groups] addObject:group];
}

- (INLGroup *)popGroup
{
    INLGroup *top = [[self groups] lastObject];
    [[self groups] removeLastObject];
    return top;
}

@end
