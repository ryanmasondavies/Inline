//
//  INLTestCase.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestCase.h"

@implementation INLTestCase

+ (NSMutableDictionary *)testInvocationsByClass
{
    static NSMutableDictionary *testInvocationsByClass = nil;
    if (testInvocationsByClass == nil) testInvocationsByClass = [NSMutableDictionary dictionary];
    return testInvocationsByClass;
}

+ (NSArray *)testInvocations
{
    NSArray *stored = [[self testInvocationsByClass] objectForKey:NSStringFromClass(self)];
    return stored ? stored : @[];
}

+ (void)setTestInvocations:(NSArray *)testInvocations
{
    [[self testInvocationsByClass] setObject:testInvocations forKey:NSStringFromClass(self)];
}

+ (void)addTestInvocation:(INLTestInvocation *)testInvocation
{
    self.testInvocations = [[self testInvocations] arrayByAddingObject:testInvocation];
}

+ (void)removeTestInvocation:(INLTestInvocation *)testInvocation
{
    NSMutableArray *stored = [[self testInvocations] mutableCopy];
    [stored removeObject:testInvocation];
    [self setTestInvocations:[stored copy]];
}

@end
