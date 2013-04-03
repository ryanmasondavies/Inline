//
//  INLStopwatch.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTimeProvider;

/** Used for recording the amount of time a process takes. */
@interface INLStopwatch : NSObject

/**
 Initialize a stopwatch.
 @param timeProvider Used to retrieve the current time.
 @return An initialized stopwatch.
 */
- (id)initWithTimeProvider:(INLTimeProvider *)timeProvider;

/** Start recording time. */
- (void)start;

/** Stop recording time. */
- (void)stop;

/** @return The amount of time elapsed between calling -start and -stop. */
- (NSTimeInterval)timeElapsed;

@end
