//
//  INLTestCase.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestCase.h"
#import "INLInvocation.h"
#import "INLTest.h"

@interface NSObject (INLTestRuntimeUtilities)
+ (NSArray *)senAllSuperclasses;
@end

@implementation INLTestCase

+ (NSArray *)testInvocations
{
    return @[];
}

+ (NSArray *)senAllSuperclasses
{
    NSArray *superclasses = [super senAllSuperclasses];
    if ([[self blacklistedClasses] containsObject:superclasses[0]]) superclasses = @[[NSObject class]];
    return superclasses;
}

+ (NSArray *)blacklistedClasses
{
    return @[[INLTestCase class]];
}

- (INLTest *)test
{
    return [(INLInvocation *)[self invocation] test];
}

- (NSString *)name
{
    NSAssert([self test], @"Must have a test.");
    return [[self test] description];
}

@end
