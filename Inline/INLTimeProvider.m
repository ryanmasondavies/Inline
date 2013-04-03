//
//  INLTimeProvider.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTimeProvider.h"

@implementation INLTimeProvider

- (NSTimeInterval)time
{
    return [[NSDate date] timeIntervalSince1970];
}

@end
