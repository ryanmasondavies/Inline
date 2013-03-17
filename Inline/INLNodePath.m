//
//  INLNodePath.m
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNodePath.h"
#import "INLGroup.h"

@interface INLNodePath ()
@property (strong, nonatomic) NSArray *groups;
@end

@implementation INLNodePath

- (id)initWithGroups:(NSArray *)groups
{
    if (self = [self init]) {
        [self setGroups:groups];
    }
    return self;
}

@end
