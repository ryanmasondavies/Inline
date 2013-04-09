//
//  INLHijacker.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#ifndef RUN_OCUNIT_TESTS

#import <Foundation/Foundation.h>
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
    
    NSMutableString *output = [[NSMutableString alloc] init];
    NSMutableArray *reporters = [[NSMutableArray alloc] init];
    reporters[0] = [[INLGroupIndenter alloc] initWithOutput:output];
    reporters[1] = [[INLTestIndenter alloc] initWithOutput:output];
    reporters[2] = [[INLGroupReporter alloc] initWithOutput:output];
    reporters[3] = [[INLTestReporter alloc] initWithOutput:output];
    reporters[4] = [[INLNewlineReporter alloc] initWithOutput:output];
    
    id<INLRunnerDelegate> reporter = [[INLReporter alloc] initWithReporters:reporters];
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:reporter];
    [groups enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger idx, BOOL *stop) {
        [runner runByStartingAtComponent:group];
    }];
    
    printf("%s", [output cStringUsingEncoding:NSUTF8StringEncoding]);
    
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
