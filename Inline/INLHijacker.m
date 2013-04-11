//
//  INLHijacker.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

//#undef RUN_OCUNIT_TESTS
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
    
    INLDateProvider *dateProvider = [[INLDateProvider alloc] init];
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    id<INLResponder> responder = [[INLResultAccumulator alloc] initWithDateProvider:dateProvider results:results];
    
    INLRunner *runner = [[INLRunner alloc] init];
    [groups enumerateObjectsUsingBlock:^(INLGroup *group, NSUInteger idx, BOOL *stop) {
        [runner runComponent:group withResponder:responder];
    }];
    
    NSLog(@"%@", results);
    
//    printf("%s", [output cStringUsingEncoding:NSUTF8StringEncoding]);
    
    exit(0);
}

@interface INLHijacker : NSObject; @end

@implementation INLHijacker

+ (void)load
{
    class_replaceMethod(objc_getMetaClass("SenTestProbe"), @selector(runTests:), (IMP)INLRunTests, "v@:@");
}

@end

@interface Tests : INLSuite; @end
@implementation Tests

- (INLGroup *)rootGroup
{
    INLTimeProvider *timeProvider = [[INLTimeProvider alloc] init];
    INLStopwatch *stopwatch = [[INLStopwatch alloc] initWithTimeProvider:timeProvider];
    
    INLPassedState *catPassed = [[INLPassedState alloc] initWithName:@"test my cat"];
    INLReadyState *catReady = [[INLReadyState alloc] initWithName:@"test my cat" block:^{} stopwatch:stopwatch passedState:catPassed failedState:nil];
    INLTest *catTest = [[INLTest alloc] initWithState:catReady weight:@0];
    
    INLFailedState *dogFailed = [[INLFailedState alloc] initWithName:@"test my dog"];
    INLReadyState *dogReady = [[INLReadyState alloc] initWithName:@"test my dog" block:^{
        [NSException raise:NSInternalInconsistencyException format:@"dog failed"];
    } stopwatch:stopwatch passedState:nil failedState:dogFailed];
    INLTest *dogTest = [[INLTest alloc] initWithState:dogReady weight:@1];
    
    NSMutableArray *tests = [@[catTest, dogTest] mutableCopy];
    NSSortDescriptor *lightestToHeaviest = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:tests sortDescriptors:@[lightestToHeaviest]];
    return [[INLGroup alloc] initWithName:@"" components:sorted weight:@0];
}

@end

#endif
