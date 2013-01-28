//
//  INLTestCase.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestCase.h"
#import "INLInvocation.h"
#import "INLBuilder.h"
#import "INLCompiler.h"
#import "INLTest.h"

@interface NSObject (INLTestRuntimeUtilities)
+ (NSArray *)senAllSuperclasses;
@end

@implementation INLTestCase

+ (NSMutableDictionary *)buildersByClass
{
    static NSMutableDictionary *buildersByClass = nil;
    if (buildersByClass == nil) buildersByClass = [NSMutableDictionary dictionary];
    return buildersByClass;
}

+ (NSMutableDictionary *)compilersByClass
{
    static NSMutableDictionary *compilersByClass = nil;
    if (compilersByClass == nil) compilersByClass = [NSMutableDictionary dictionary];
    return compilersByClass;
}

+ (INLBuilder *)builder
{
    return [[self buildersByClass] objectForKey:NSStringFromClass(self)];
}

+ (void)setBuilder:(INLBuilder *)builder
{
    if (builder)
        [[self buildersByClass] setObject:builder forKey:NSStringFromClass(self)];
    else
        [[self buildersByClass] removeObjectForKey:NSStringFromClass(self)];
}

+ (id<INLCompiler>)compiler
{
    return [[self compilersByClass] objectForKey:NSStringFromClass(self)];
}

+ (void)setCompiler:(id<INLCompiler>)compiler
{
    if (compiler)
        [[self compilersByClass] setObject:compiler forKey:NSStringFromClass(self)];
    else
        [[self compilersByClass] removeObjectForKey:NSStringFromClass(self)];
}

+ (NSArray *)testInvocations
{
    return [[self compiler] invocationsForGroup:[[self builder] rootGroup]];
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

- (NSString *)name
{
    INLInvocation *invocation = (INLInvocation *)[self invocation];
    INLTest *test = [invocation test];
    return [test description];
}

@end
