//
//  INLBlockInvocation.m
//  Inline
//
//  Created by Ryan Davies on 12/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLBlockInvocation.h"

@interface INLBlockInvocation ()
@property (copy, nonatomic) INLVoidBlock block;
@end

@implementation INLBlockInvocation

+ (id)invocationWithBlock:(INLVoidBlock)block
{
    NSString *encodingType = [NSString stringWithFormat:@"%s%s%s", @encode(void), @encode(id), @encode(SEL)];
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:[encodingType UTF8String]];
    INLBlockInvocation *invocation = (id)[INLBlockInvocation invocationWithMethodSignature:methodSignature];
    [invocation setBlock:block];
    return invocation;
}

- (void)invoke
{
    [self block]();
}

@end
