//
//  INLBuilder.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLBuilder.h"
#import "INLGroup.h"

@implementation INLBuilder

- (id)init
{
    if (self = [super init]) {
        self.rootGroup = [[INLGroup alloc] init];
    }
    return self;
}

@end
