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
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:dateProvider publisher:nil results:results];
    
    // when
    [reporter runDidStart];
    
    // then
    [[@(results[@"startDate"] != nil) should] beTrue];
    [[results[@"startDate"] should] beEqualTo:date];
}

- (void)testWhenOneTestPassesAddsNameAndDurationToResults
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:nil publisher:nil results:results];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"the great test"] name];
    [reporter testDidPass:test withDuration:1];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"duration"] should] beEqualTo:@1];
}

- (void)testWhenTwoTestsPassAddsNameAndDurationToResults
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:nil publisher:nil results:results];
    
    // when
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    [@[@"the great test", @"the other great test"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        tests[idx] = [OCMockObject niceMockForClass:[INLTest class]];
        [[[tests[idx] stub] andReturn:name] name];
        [reporter testDidPass:tests[idx] withDuration:idx];
    }];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"duration"] should] beEqualTo:@0];
    [[results[@"tests"][1][@"name"] should] beEqualTo:@"the other great test"];
    [[results[@"tests"][1][@"duration"] should] beEqualTo:@1];
}

- (void)testWhenRunFinishesAddsFinishDateToResults
{
    // given
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLReporter *reporter = [[INLReporter alloc] initWithDateProvider:dateProvider publisher:nil results:results];
    
    // when
    [reporter runDidFinish];
    
    // then
    [[@(results[@"finishDate"] != nil) should] beTrue];
    [[results[@"finishDate"] should] beEqualTo:date];
}

@end
