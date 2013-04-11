//
//  INLResultAccumulator.m
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLResultAccumulator.h"
#import "INLDateProvider.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLResultAccumulator ()
@property (strong, nonatomic) INLDateProvider *dateProvider;
@property (strong, nonatomic) NSMutableDictionary *results;
@end

@implementation INLResultAccumulator

- (id)initWithDateProvider:(INLDateProvider *)dateProvider results:(NSMutableDictionary *)results
{
    if (self = [self init]) {
        [self setDateProvider:dateProvider];
        [self setResults:results];
    }
    return self;
}

- (void)runDidStart
{
    [[self results] setObject:[[self dateProvider] currentDate] forKey:@"startDate"];
}

- (void)runDidFinish
{
    [[self results] setObject:[[self dateProvider] currentDate] forKey:@"finishDate"];
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
    [[self results][@"tests"] addObject:@{@"name": [test name], @"duration": @(duration)}];
}

- (void)testDidSkip:(INLTest *)test
{
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
    NSDictionary *failure = nil;
    NSString *filePath = [exception userInfo][SenTestFilenameKey];
    NSNumber *lineNumber = [exception userInfo][SenTestLineNumberKey];
    if (filePath && lineNumber) {
        failure = @{@"reason": [exception reason], @"filePath": filePath, @"lineNumber": lineNumber};
    } else {
        failure = @{@"reason": [exception reason]};
    }
    [[self results][@"tests"] addObject:@{@"name": [test name], @"failure": failure}];
}

@end
