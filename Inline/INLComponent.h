//
//  INLComponent.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLResponder;

/** The interface for groups, tests, and hooks to conform to. */
@protocol INLComponent <NSObject>

/**
 Run a component.
 For a group, this means to run each component, in order, and notify the responder that a group has started and finished.
 A test will be run and the responder notified of the outcome.
 @param responder A responder to be notified of events during the run.
 */
- (void)runWithResponder:(id<INLResponder>)responder;

/** @return A numerical value used for ordering components within a component graph. */
- (NSNumber *)weight;

@end
