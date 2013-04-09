//
//  INLNode.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLReporter;

/** The interface for groups, tests, and hooks to conform to. */
@protocol INLNode <NSObject>

/**
 Run a node.
 For a group, this means to run each component, in order, and notify the reporter that a group has started and finished.
 A test will be run and the reporter notified of the outcome.
 @param reporter A reporter to be notified of events during the run.
 */
- (void)runWithReporter:(INLReporter *)reporter;

/** @return A numerical value used for ordering nodes within a node graph. */
- (NSNumber *)weight;

@end
