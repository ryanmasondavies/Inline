//
//  INLReadyState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReadyState.h"
#import "INLStopwatch.h"
#import "INLResponder.h"
#import "INLTest.h"

@interface INLReadyState ()
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) INLStopwatch *stopwatch;
@property (strong, nonatomic) INLTestBlock block;
@property (strong, nonatomic) id<INLTestState> passedState;
@property (strong, nonatomic) id<INLTestState> failedState;
@end

@implementation INLReadyState

- (id)initWithName:(NSString *)name block:(INLTestBlock)block stopwatch:(INLStopwatch *)stopwatch passedState:(id<INLTestState>)passedState failedState:(id<INLTestState>)failedState
{
    if (self = [self init]) {
        [self setName:name];
        [self setBlock:block];
        [self setStopwatch:stopwatch];
        [self setPassedState:passedState];
        [self setFailedState:failedState];
    }
    return self;
}

- (void)runWithResponder:(id<INLResponder>)responder forTest:(INLTest *)test
{
    [[self stopwatch] start];
    NSException *exception = nil;
    @try { [self block](); }
    @catch (NSException *e) { exception = e; }
    [[self stopwatch] stop];
    
    if (exception == nil) {
        [responder testDidPass:test withDuration:[[self stopwatch] timeElapsed]];
        [test transitionToState:[self passedState]];
    } else {
        [responder testDidFail:test withException:exception];
        [test transitionToState:[self failedState]];
    }
}

@end
