//
//  INLReporter.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReporter.h"
#import "INLDateProvider.h"
#import "INLPublisher.h"

@interface INLReporter ()
@property (strong, nonatomic) INLDateProvider *dateProvider;
@property (strong, nonatomic) NSMutableDictionary *report;
@property (strong, nonatomic) id<INLPublisher> publisher;
@end

@implementation INLReporter

- (id)initWithDateProvider:(INLDateProvider *)dateProvider publisher:(id<INLPublisher>)publisher report:(NSMutableDictionary *)report
{
    if (self = [self init]) {
        [self setDateProvider:dateProvider];
        [self setPublisher:publisher];
        [self setReport:report];
    }
    return self;
}

- (void)runDidStart
{
    [[self report] setObject:[[self dateProvider] currentDate] forKey:@"startDate"];
}

- (void)runDidFinish
{
    [[self report] setObject:[[self dateProvider] currentDate] forKey:@"finishDate"];
}

- (void)groupDidStart:(INLGroup *)group
{
}

- (void)groupDidFinish:(INLGroup *)group
{
}

- (void)testDidStart:(INLTest *)test
{
}

- (void)testDidPass:(INLTest *)test withDuration:(NSTimeInterval)duration
{
}

- (void)testDidSkip:(INLTest *)test
{
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
}

@end
