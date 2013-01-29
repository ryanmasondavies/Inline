//
//  INLCompiler.m
//  Inline
//
//  Created by Ryan Davies on 29/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLCompiler.h"
#import "INLInvocation.h"
#import "INLGroup.h"
#import "INLTest.h"

@implementation INLCompiler

- (NSArray *)invocationsForGroup:(INLGroup *)group
{
    NSMutableArray *tests = [NSMutableArray array];
    NSMutableArray *groupQueue = [NSMutableArray arrayWithObject:group];
    
    INLGroup *currentGroup = [groupQueue objectAtIndex:0];
    [groupQueue removeObjectAtIndex:0];
    
    while (currentGroup) {
        [tests addObjectsFromArray:[currentGroup tests]];
        [groupQueue addObjectsFromArray:[currentGroup groups]];
        
        if ([groupQueue count] > 0) {
            currentGroup = [groupQueue objectAtIndex:0];
            [groupQueue removeObjectAtIndex:0];
        } else {
            currentGroup = nil;
        }
    }
    
    NSMutableArray *invocations = [NSMutableArray array];
    [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
        [invocations addObject:[INLInvocation invocationWithTest:test]];
    }];
    
    return [NSArray arrayWithArray:invocations];
}

@end
