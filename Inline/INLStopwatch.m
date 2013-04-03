//
//  INLStopwatch.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLStopwatch.h"
#import "INLTimeProvider.h"

@interface INLStopwatch ()
@property (strong, nonatomic) INLTimeProvider *timeProvider;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval endTime;
@end

@implementation INLStopwatch

- (id)initWithTimeProvider:(INLTimeProvider *)timeProvider
{
    if (self = [self init]) {
        [self setTimeProvider:timeProvider];
        [self setStartTime:0];
        [self setEndTime:0];
    }
    return self;
}

- (void)start
{
    [self setStartTime:[[self timeProvider] time]];
}

- (void)stop
{
    [self setEndTime:[[self timeProvider] time]];
}

- (NSTimeInterval)timeElapsed
{
    return [self endTime] - [self startTime];
}

@end
