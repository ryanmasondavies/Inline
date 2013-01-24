//
//  INLTestCase.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestCase.h"
#import "INLTestInvocation.h"
#import "INLTest.h"

@implementation INLTestCase

+ (NSMutableDictionary *)buildersByClass
{
    static NSMutableDictionary *buildersByClass = nil;
    if (buildersByClass == nil) buildersByClass = [NSMutableDictionary dictionary];
    return buildersByClass;
}

+ (id<INLTestBuilder>)builder
{
    return [[self buildersByClass] objectForKey:NSStringFromClass(self)];
}

+ (void)setBuilder:(id<INLTestBuilder>)builder
{
    return [[self buildersByClass] setObject:builder forKey:NSStringFromClass(self)];
}

@end
