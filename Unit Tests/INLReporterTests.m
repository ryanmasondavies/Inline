//
//  INLReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLReporterTests : SenTestCase

@end

@implementation INLReporterTests

- (void)testWhenRunStartsAddsStartDateToResults
{
    // given
    NSMutableDictionary *report = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:dateProvider publisher:nil report:report];
    
    // when
    [reporter runDidStart];
    
    // then
    [[@(report[@"startDate"] != nil) should] beTrue];
    [[report[@"startDate"] should] beEqualTo:date];
}

- (void)testWhenRunFinishesAddsFinishDateToResults
{
    // given
    NSMutableDictionary *report = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:dateProvider publisher:nil report:report];
    
    // when
    [reporter runDidFinish];
    
    // then
    [[@(report[@"finishDate"] != nil) should] beTrue];
    [[report[@"finishDate"] should] beEqualTo:date];
}

@end
