//
//  INLRunner.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLComponent, INLResponder;

/** Runs through a component hierarchy. Necessary to invoke [INLResponder start] and [INLResponder stop]. */
@interface INLRunner : NSObject

/**
 Run a component.
 @param component The component to start the run at.
 @param responder The responder to inform of events during the run.
 */
- (void)runComponent:(id<INLComponent>)component withResponder:(id<INLResponder>)responder;

@end
