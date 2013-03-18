//
//  INLNodeRunner.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNodeRunner.h"
#import "INLTest.h"
#import "INLHook.h"

@implementation INLNodeRunner

- (void)visitTest:(INLTest *)test
{
    [test run];
}

- (void)visitHook:(INLHook *)hook
{
    [hook run];
}

@end
