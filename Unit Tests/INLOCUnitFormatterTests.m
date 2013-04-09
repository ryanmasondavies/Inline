//
//  INLOCUnitFormatterTests.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLOCUnitFormatterTests : SenTestCase

@end

@implementation INLOCUnitFormatterTests

- (void)testWhenWritingRunStartsWritesOCUnitSuiteStarted
{
    // given
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLOCUnitFormatter *formatter = [[INLOCUnitFormatter alloc] initWithDateProvider:dateProvider suiteName:@"Suite"];
    
    // when
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeRunDidStartToReport:report];
    
    // then
    [[report should] beEqualTo:@"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"];
}

- (void)testWhenWritingRunFinishesWritesOCUnitSuiteFinished
{
    // given
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLOCUnitFormatter *formatter = [[INLOCUnitFormatter alloc] initWithDateProvider:dateProvider suiteName:@"Suite"];
    
    // when
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeRunDidFinishToReport:report];
    
    // then
    BOOL found = [report rangeOfString:@"Test Suite 'Suite' finished at 1970-01-01 00:00:00 +0000.\n"].location != NSNotFound;
    [[@(found) should] beTrue];
}

@end
