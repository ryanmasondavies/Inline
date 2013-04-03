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
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSSortDescriptor *lightestToHeaviest = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES];
    CBDSortedArray *sortedNodes = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[lightestToHeaviest]];
    INLGroup *group = [[INLGroup alloc] initWithLabel:@"" nodes:sortedNodes weight:@0];
    
    NSArray *subclasses = [[INLSuite class] subclasses];
    [subclasses enumerateObjectsUsingBlock:^(Class subclass, NSUInteger idx, BOOL *stop) {
        INLSuite *suite = [[subclass alloc] init];
        [suite addNodesToGroup:group];
    }];
    
    INLRunner *runner = [[INLRunner alloc] init];
    [group acceptVisitor:runner];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    [group acceptVisitor:reporter];
    
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
