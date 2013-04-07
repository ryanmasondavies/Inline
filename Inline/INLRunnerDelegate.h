//
//  INLRunnerDelegate.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup, INLTest;
@protocol INLNode;

/** Used for notifying interested parties about the progress of a runner, e.g reporters. */
@protocol INLRunnerDelegate <NSObject>

/**
 Sent when the runner starts running with a node of any kind.
 @param node The node the runner has started with.
 */
- (void)willStartRunningWithNode:(id<INLNode>)node;

/**
 Sent when the runner has finished running through a node hierarchy.
 @param node The node the runner has stopped running.
 */
- (void)didFinishRunningWithNode:(id<INLNode>)node;

/**
 Sent when the runner enters a group.
 @param group The group entered.
 */
- (void)didEnterGroup:(INLGroup *)group;

/**
 Sent when the runner leaves a group.
 @param group The group left.
 */
- (void)didLeaveGroup:(INLGroup *)group;

/**
 Sent when the runner is about to run a test.
 @param test The test to be run.
 */
- (void)willRunTest:(INLTest *)test;

/**
 Sent when the runner has run a test.
 @param test The test that has been run.
 */
- (void)didRunTest:(INLTest *)test;

@end
