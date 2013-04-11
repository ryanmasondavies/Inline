//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 17/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLDateProvider, INLGroup, INLTest, INLHook;
@protocol INLPublisher;

/** A reporter is notified as a run event propagates through a component hierarchy. */
@interface INLReporter : NSObject

/**
 Initialize a reporter.
 @param dateProvider A necessary abstraction for testing purposes, used to retrieve the current date.
 @param publisher Publishes the report.
 @param results Accumulated as the reporter is notified about events.
 @return An initialized reporter.
 */
- (id)initWithDateProvider:(INLDateProvider *)dateProvider publisher:(id<INLPublisher>)publisher results:(NSMutableDictionary *)results;

@end
