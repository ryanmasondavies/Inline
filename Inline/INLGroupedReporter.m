//
//  INLGroupedReporter.m
//  Inline
//
//  Created by Ryan Davies on 06/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroupedReporter.h"
#import "INLTestCase.h"
#import "INLInvocation.h"
#import "INLTest.h"
#import "INLGroup.h"

@interface INLGroupedReporter ()
@property (strong, nonatomic) NSMutableArray *history;
@end

@implementation INLGroupedReporter

+ (void)initialize
{
    if ([self class] == [INLGroupedReporter class]) {
        [TSCObserver setActiveReporter:[self new]];
    }
}

- (id)init
{
    if (self = [super init]) {
        self.history = [NSMutableArray array];
    }
    return self;
}

- (void)testDidEnd:(NSNotification *)notification
{
    // Retrieve the test:
    SenTestRun *run = [notification run];
    INLTestCase *testCase = (INLTestCase *)[run test];
    INLInvocation *invocation = (INLInvocation *)[testCase invocation];
    INLTest *test = [invocation test];
    
    // Create stack of groups and test
    id target = test;
    NSMutableArray *stack = [NSMutableArray array];
    while ((target = [target parent]) != nil) [stack insertObject:target atIndex:0];
    [stack addObject:test];
    
    // Print out stack
    [stack enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self.history containsObject:obj]) return;
        NSString *label = [obj label];
        if (label != nil) {
            if (idx == [stack count] - 1) {
                if ([obj state] == INLTestStatePending) {
                    [self log:@"[P]"];
                }
                
                if ([[notification run] hasSucceeded] == NO) {
                    [self log:@"[F]"];
                }
            }
            
            for (NSUInteger i = 0; i < idx; i ++) [self log:@"\t"];
            [self log:label];
            [self log:@"\n"];
        }
        [self.history addObject:obj];
    }];
}

@end
