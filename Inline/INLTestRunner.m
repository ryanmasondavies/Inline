//
//  INLTestRunner.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestRunner.h"
#import "INLTest.h"
#import "INLHook.h"

@implementation INLTestRunner

- (void)visitTest:(INLTest *)test
{
    [test run];
}

- (void)visitHook:(INLHook *)hook
{
    [hook run];
}

@end
