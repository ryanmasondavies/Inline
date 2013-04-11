//
//  INLHijacker.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#ifndef RUN_OCUNIT_TESTS

#import <Foundation/Foundation.h>
#import <GRMustache/GRMustache.h>
#import <InflectorKit/NSString+InflectorKit.h>
#import <TransformerKit/TransformerKit.h>
#import <objc/objc-runtime.h>
#import "Inline.h"

@interface NSObject (INLHierarchy)
+ (NSArray *)subclasses;
@end

@implementation NSObject (INLHierarchy)

+ (NSArray *)subclasses
{
    int numberOfClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    if (numberOfClasses > 0) {
        NSMutableArray *subclasses = [NSMutableArray array];
        
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numberOfClasses);
        numberOfClasses = objc_getClassList(classes, numberOfClasses);
        
        for (int i = 0; i < numberOfClasses; i++) {
            if (class_getSuperclass(classes[i]) == self) {
                [subclasses addObject:classes[i]];
            }
        }
        
        free(classes);
        
        return subclasses;
    }
    
    return nil;
}

@end

void INLRunTests(id self, SEL _cmd, id ignored)
{
    NSArray *subclasses = [[INLSuite class] subclasses];
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    [subclasses enumerateObjectsUsingBlock:^(Class subclass, NSUInteger idx, BOOL *stop) {
        INLSuite *suite = [[subclass alloc] init];
        [groups addObject:[suite rootGroup]];
    }];
    
    INLDateProvider *dateProvider = [[INLDateProvider alloc] init];
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    id<INLResponder> responder = [[INLResultAccumulator alloc] initWithDateProvider:dateProvider results:results];
    
    INLRunner *runner = [[INLRunner alloc] init];
    [groups enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger idx, BOOL *stop) {
        [runner runComponent:group withResponder:responder];
    }];
    
    NSNumberFormatter *threeDecimalPoints = [[NSNumberFormatter alloc] init];
    [threeDecimalPoints setNumberStyle:NSNumberFormatterDecimalStyle];
    [threeDecimalPoints setMinimumFractionDigits:3];
    [threeDecimalPoints setMaximumFractionDigits:3];
    
    [results addEntriesFromDictionary:@{
        @"threeDecimalPoints": threeDecimalPoints,
        @"pluralize": [GRMustacheFilter filterWithBlock:^id(NSNumber *count) {
            return [GRMustache renderingObjectWithBlock:^NSString *(GRMustacheTag *tag, GRMustacheContext *context, BOOL *HTMLSafe, NSError *__autoreleasing *error) {
                NSString *word = [tag renderContentWithContext:context HTMLSafe:HTMLSafe error:error];
                return [count isEqualToNumber:@1] ? word : [word pluralizedString];
            }];
        }],
        @"llamaCase": [NSValueTransformer valueTransformerForName:TKLlamaCaseStringTransformerName],
        @"numberOfFailures": [GRMustacheFilter filterWithBlock:^id(NSArray *tests) {
            __block NSUInteger failures = 0;
            [tests enumerateObjectsUsingBlock:^(NSDictionary *test, NSUInteger idx, BOOL *stop) {
                if (test[@"failure"]) {
                    failures ++;
                }
            }];
            return @(failures);
        }]
    }];
    
    GRMustacheTemplate *template = [GRMustacheTemplate templateFromResource:@"OCUnit" bundle:[NSBundle mainBundle] error:NULL];
    NSString *report = [template renderObject:results error:NULL];
    printf("%s", [report cStringUsingEncoding:NSUTF8StringEncoding]);
    
    exit(0);
}

@interface INLHijacker : NSObject; @end

@implementation INLHijacker

+ (void)load
{
    class_replaceMethod(objc_getMetaClass("SenTestProbe"), @selector(runTests:), (IMP)INLRunTests, "v@:@");
}

@end

#endif
