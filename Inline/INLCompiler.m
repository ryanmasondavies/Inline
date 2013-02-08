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

- (NSMutableArray *)invocationsForTests:(NSArray *)tests
{
    NSMutableArray *invocations = [NSMutableArray array];
    [tests enumerateObjectsUsingBlock:^(INLTest *test, NSUInteger idx, BOOL *stop) {
        [invocations addObject:[INLInvocation invocationWithTest:test]];
    }];
    return invocations;
}

- (NSArray *)invocationsForGroup:(INLGroup *)group
{
    NSMutableArray *invocations = [self invocationsForTests:[group tests]];
    [[group groups] enumerateObjectsUsingBlock:^(INLGroup *nested, NSUInteger idx, BOOL *stop) {
        [invocations addObjectsFromArray:[self invocationsForGroup:nested]];
    }];
    return [NSArray arrayWithArray:invocations];
}

@end
