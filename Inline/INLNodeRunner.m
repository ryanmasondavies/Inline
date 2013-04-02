//
//  INLNodeRunner.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNodeRunner.h"
#import "INLGroup.h"
#import "INLTest.h"
#import "INLHook.h"

@implementation INLNodeRunner

- (void)visitGroup:(INLGroup *)group
{
}

- (void)visitTest:(INLTest *)test
{
    [test run];
}

- (void)visitHook:(INLHook *)hook
{
    [hook run];
}

- (void)leaveGroup:(INLGroup *)group
{
}

@end
