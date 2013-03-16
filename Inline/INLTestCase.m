//
//  INLTestCase.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestCase.h"
#import "INLInvocation.h"
#import "INLStack.h"
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

+ (INLStack *)builder
{
    INLStack *builder = [[self buildersByClass] objectForKey:NSStringFromClass(self)];
    if (builder == nil) {
        builder = [[INLStack alloc] init];
        [self setBuilder:builder];
    }
    
    return builder;
}

+ (void)setBuilder:(INLStack *)builder
{
    if (builder)
        [[self buildersByClass] setObject:builder forKey:NSStringFromClass(self)];
    else
        [[self buildersByClass] removeObjectForKey:NSStringFromClass(self)];
}

+ (INLCompiler *)compiler
{
    INLCompiler *compiler = [[self compilersByClass] objectForKey:NSStringFromClass(self)];
    if (compiler == nil) {
        compiler = [[INLCompiler alloc] init];
        [self setCompiler:compiler];
    }
    
    return compiler;
}

+ (void)setCompiler:(INLCompiler *)compiler
{
    if (compiler)
        [[self compilersByClass] setObject:compiler forKey:NSStringFromClass(self)];
    else
        [[self compilersByClass] removeObjectForKey:NSStringFromClass(self)];
}

+ (NSArray *)testInvocations
{
//    NSAssert([self compiler], @"Must have a compiler.");
//    NSAssert([self builder],  @"Must have a builder.");
//    return [[self compiler] invocationsForGroup:[[self builder] rootGroup]];
    
    return nil;
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
