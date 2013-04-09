//
//  INLRunner.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLRunner.h"
#import "INLComponent.h"
#import "INLReporter.h"

@implementation INLRunner

- (void)runComponent:(id<INLComponent>)component withReporter:(INLReporter *)reporter
{
    [reporter runDidStart];
    [component runWithReporter:reporter];
    [reporter runDidFinish];
}

@end
