//
//  INLInvocation.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLInvocation.h"
#import "INLTest.h"

@implementation INLInvocation

+ (instancetype)invocationWithTest:(id <INLTest>)test
{
    NSString *encodingType = [NSString stringWithFormat:@"%s%s%s", @encode(void), @encode(id), @encode(SEL)];
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:[encodingType UTF8String]];
    INLInvocation *invocation = (id)[INLInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTest:test];
    return invocation;
}

- (void)invoke
{
    [[self test] execute];
}

@end
