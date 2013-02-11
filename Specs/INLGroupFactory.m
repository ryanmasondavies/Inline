//
//  INLGroupFactory.m
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroupFactory.h"

@implementation INLGroupFactory

+ (INLGroup *)createGroupLabelled:(NSString *)label
{
    INLGroup *group = [[INLGroup alloc] init];
    [group setLabel:label];
    return group;
}

@end
