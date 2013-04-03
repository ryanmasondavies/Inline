//
//  INLRunner.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLRunner.h"
#import "INLGroup.h"
#import "INLTest.h"
#import "INLHook.h"

@implementation INLRunner

- (void)enterGroup:(INLGroup *)group
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
