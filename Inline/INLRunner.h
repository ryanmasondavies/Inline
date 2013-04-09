//
//  INLRunner.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLReporter;
@protocol INLComponent;

/** Begins propogating a run through a component hierarchy. Necessary to invoke [INLReporter start] and [INLReporter stop]. */
@interface INLRunner : NSObject

/**
 Run a component.
 @param component The component to start the run at.
 @param reporter The reporter to inform of events during the run.
 */
- (void)runComponent:(id<INLComponent>)component withReporter:(INLReporter *)reporter;

@end
