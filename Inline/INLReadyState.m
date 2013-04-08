//
//  INLReadyState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReadyState.h"
#import "INLReporter.h"
#import "INLTest.h"

@interface INLReadyState ()
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) INLTestBlock block;
@property (strong, nonatomic) id<INLTestState> passedState;
@property (strong, nonatomic) id<INLTestState> failedState;
@end

@implementation INLReadyState

- (id)initWithName:(NSString *)name block:(INLTestBlock)block passedState:(id<INLTestState>)passedState failedState:(id<INLTestState>)failedState
{
    if (self = [self init]) {
        [self setName:name];
        [self setBlock:block];
        [self setPassedState:passedState];
        [self setFailedState:failedState];
    }
    return self;
}

- (void)runWithReporter:(id<INLReporter>)reporter forTest:(INLTest *)test
{
    NSException *exception = nil;
    @try { [self block](); }
    @catch (NSException *e) { exception = e; }
    
    if (exception == nil) {
        [reporter testDidPass:test];
        [test transitionToState:[self passedState]];
    } else {
        [reporter testDidFail:test withException:exception];
        [[self failedState] setReason:[exception reason]];
        [test transitionToState:[self failedState]];
    }
}

- (void)setReason:(NSString *)reason
{
}

@end
