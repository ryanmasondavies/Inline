//
//  INLRunner.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLRunner.h"
#import "INLStopwatch.h"
#import "INLComponent.h"
#import "INLResponder.h"

@interface INLRunner ()
@property (strong, nonatomic) INLStopwatch *stopwatch;
@end

@implementation INLRunner

- (id)initWithStopwatch:(INLStopwatch *)stopwatch
{
    if (self = [self init]) {
        [self setStopwatch:stopwatch];
    }
    return self;
}

- (void)runComponent:(id<INLComponent>)component withResponder:(id<INLResponder>)responder
{
    [[self stopwatch] start];
    [responder runDidStart];
    [component runWithResponder:responder];
    [[self stopwatch] stop];
    [responder runDidFinishWithDuration:[[self stopwatch] timeElapsed]];
}

@end
