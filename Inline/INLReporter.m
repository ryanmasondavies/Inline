//
//  INLReporter.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReporter.h"
#import "INLFormatter.h"
#import "INLPublisher.h"

@interface INLReporter ()
@property (strong, nonatomic) NSMutableString *report;
@property (strong, nonatomic) id<INLFormatter> formatter;
@property (strong, nonatomic) id<INLPublisher> publisher;
@end

@implementation INLReporter

- (id)initWithFormatter:(id<INLFormatter>)formatter publisher:(id<INLPublisher>)publisher report:(NSMutableString *)report
{
    if (self = [self init]) {
        [self setFormatter:formatter];
        [self setPublisher:publisher];
        [self setReport:report];
    }
    return self;
}

- (void)groupDidStart:(INLGroup *)group
{
    [[self formatter] writeGroupDidStart:group toReport:[self report]];
}

- (void)groupDidFinish:(INLGroup *)group
{
    [[self formatter] writeGroupDidFinish:group toReport:[self report]];
}

- (void)testDidStart:(INLTest *)test
{
    [[self formatter] writeTestDidStart:test toReport:[self report]];
}

- (void)testDidPass:(INLTest *)test withDuration:(NSTimeInterval)duration
{
    [[self formatter] writeTestDidPass:test withDuration:0 toReport:[self report]];
}

- (void)testDidSkip:(INLTest *)test
{
    [[self formatter] writeTestDidSkip:test toReport:[self report]];
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
    [[self formatter] writeTestDidFail:test withException:exception toReport:[self report]];
}

@end
