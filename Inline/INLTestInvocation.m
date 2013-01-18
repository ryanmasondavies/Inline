//
//  INLTestInvocation.m
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestInvocation.h"
#import "INLTest.h"

@implementation INLTestInvocation

+ (instancetype)invocationWithTest:(INLTest *)test
{
    NSString *encodingType = [NSString stringWithFormat:@"%s%s%s", @encode(void), @encode(id), @encode(SEL)];
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:[encodingType UTF8String]];
    INLTestInvocation *invocation = (id)[INLTestInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTest:test];
    return invocation;
}

- (void)invoke
{
    [[self test] execute];
}

@end
