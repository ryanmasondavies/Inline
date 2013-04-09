//
//  INLOCUnitFormatter.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLOCUnitFormatter.h"
#import "INLDateProvider.h"
#import "INLTest.h"
#import "INLGroup.h"

@interface INLOCUnitFormatter ()
@property (strong, nonatomic) INLDateProvider *dateProvider;
@property (copy, nonatomic) NSString *suiteName;
@end

@implementation INLOCUnitFormatter

- (id)initWithDateProvider:(INLDateProvider *)dateProvider suiteName:(NSString *)suiteName
{
    if (self = [self init]) {
        [self setDateProvider:dateProvider];
        [self setSuiteName:suiteName];
    }
    return self;
}

- (void)writeRunDidStartToReport:(NSMutableString *)report
{
    [report appendString:[NSString stringWithFormat:@"Test Suite '%@' started at %@\n", [self suiteName], [[self dateProvider] currentDate]]];
}

- (void)writeRunDidFinishToReport:(NSMutableString *)report
{
    [report appendString:[NSString stringWithFormat:@"Test Suite '%@' finished at %@.\n", [self suiteName], [[self dateProvider] currentDate]]];
}

- (void)writeGroupDidStart:(INLGroup *)group toReport:(NSMutableString *)report
{
}

- (void)writeGroupDidFinish:(INLGroup *)group toReport:(NSMutableString *)report
{
}

- (void)writeTestDidStart:(INLTest *)test toReport:(NSMutableString *)report
{
}

- (void)writeTestDidPass:(INLTest *)test withDuration:(NSTimeInterval)duration toReport:(NSMutableString *)report
{
}

- (void)writeTestDidSkip:(INLTest *)test toReport:(NSMutableString *)report
{
}

- (void)writeTestDidFail:(INLTest *)test withException:(NSException *)exception toReport:(NSMutableString *)report
{
}

@end
