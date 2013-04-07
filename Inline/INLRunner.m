//
//  INLRunner.m
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLRunner.h"
#import "INLRunnerDelegate.h"
#import "INLGroup.h"
#import "INLTest.h"
#import "INLHook.h"

@interface INLRunner ()
@property (assign, nonatomic) id<INLRunnerDelegate> delegate;
@end

@implementation INLRunner

- (id)initWithDelegate:(id<INLRunnerDelegate>)delegate
{
    if (self = [self init]) {
        [self setDelegate:delegate];
    }
    return self;
}

- (void)runByStartingAtNode:(id<INLNode>)node
{
    [[self delegate] willStartRunningWithNode:node];
    [node acceptVisitor:self];
    [[self delegate] didFinishRunningWithNode:node];
}

- (void)enterGroup:(INLGroup *)group
{
    [[self delegate] didEnterGroup:group];
}

- (void)visitTest:(INLTest *)test
{
    [[self delegate] willRunTest:test];
    [test run];
    [[self delegate] didRunTest:test];
}

- (void)visitHook:(INLHook *)hook
{
    [hook run];
}

- (void)leaveGroup:(INLGroup *)group
{
    [[self delegate] didLeaveGroup:group];
}

@end
