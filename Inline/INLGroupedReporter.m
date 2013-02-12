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
#import "INLNodePath.h"
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

- (INLTest *)testFromNotification:(NSNotification *)notification
{
    NSAssert(notification, @"Must be passed a notification.");
    
    SenTestRun *run = [notification run];
    INLTestCase *testCase = (INLTestCase *)[run test];
    INLInvocation *invocation = (INLInvocation *)[testCase invocation];
    
    return [invocation test];
}

- (NSString *)prefixForNode:(INLNode *)node inRun:(SenTestRun *)run
{
    NSAssert(node, @"Must be passed a node.");
    NSAssert(run,  @"Must be passed a run.");
    
    if ([node isKindOfClass:[INLTest class]] == NO) return nil;
    return [self prefixForTest:(INLTest *)node inRun:run];
}

- (NSString *)prefixForTest:(INLTest *)test inRun:(SenTestRun *)run
{
    NSAssert(test, @"Must be passed a test.");
    NSAssert(run,  @"Must be passed a run.");
    
    if ([test state] == INLTestStatePending) return @"[P]";
    if ([run hasSucceeded] == NO) return @"[F]";
    
    return nil;
}

- (NSArray *)pathForNotification:(NSNotification *)notification
{
    NSAssert(notification, @"Must be passed a notification.");
    INLTest *test = [self testFromNotification:notification];
    return [[[INLNodePath nodePathForDestinationNode:test] nodes] arrayByAddingObject:test];
}

- (void)logLabel:(NSString *)label prefix:(NSString *)prefix indentLevel:(NSUInteger)indentLevel
{
    if (label == nil) return;
    if (prefix) [self log:prefix];
    for (NSUInteger i = 0; i < indentLevel; i ++) [self log:@"\t"];
    [self log:label];
    [self log:@"\n"];
}

- (void)testDidEnd:(NSNotification *)notification
{
    NSAssert(notification, @"Must be passed a notification.");
    
    if ([[notification test] isKindOfClass:[INLTestCase class]] == NO) {
        [super testDidEnd:notification];
        return;
    }
    
    [[self pathForNotification:notification] enumerateObjectsUsingBlock:^(INLNode *node, NSUInteger idx, BOOL *stop) {
        if ([self.history containsObject:node]) return;
        [self logLabel:[node label] prefix:[self prefixForNode:node inRun:[notification run]] indentLevel:idx];
        [self.history addObject:node];
    }];
}

@end
