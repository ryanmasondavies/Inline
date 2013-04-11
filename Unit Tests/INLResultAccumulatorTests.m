//
//  INLResultAccumulatorTests.m
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLResultAccumulatorTests : SenTestCase

@end

@implementation INLResultAccumulatorTests

- (void)testWhenRunStartsAddsStartDate
{
    // given
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:dateProvider results:results];
    
    // when
    [accumulator runDidStart];
    
    // then
    [[@(results[@"startDate"] != nil) should] beTrue];
    [[results[@"startDate"] should] beEqualTo:date];
}

- (void)testWhenOneTestPassesAddsNameAndDuration
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:nil results:results];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"the great test"] name];
    [accumulator testDidPass:test withDuration:1];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"duration"] should] beEqualTo:@1];
}

- (void)testWhenTwoTestsPassAddsNameAndDuration
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:nil results:results];
    
    // when
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    [@[@"the great test", @"the other great test"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        tests[idx] = [OCMockObject niceMockForClass:[INLTest class]];
        [[[tests[idx] stub] andReturn:name] name];
        [accumulator testDidPass:tests[idx] withDuration:idx];
    }];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"duration"] should] beEqualTo:@0];
    [[results[@"tests"][1][@"name"] should] beEqualTo:@"the other great test"];
    [[results[@"tests"][1][@"duration"] should] beEqualTo:@1];
}

- (void)testWhenOneTestFailsAddsNameAndFilePathAndLineNumberAndReason
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:nil results:results];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"the great test"] name];
    NSDictionary *info = @{SenTestFilenameKey: @"SomeFile.m", SenTestLineNumberKey: @100};
    NSException *exception = [[NSException alloc] initWithName:NSInternalInconsistencyException reason:@"general failure" userInfo:info];
    [accumulator testDidFail:test withException:exception];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"failure"][@"filePath"] should] beEqualTo:@"SomeFile.m"];
    [[results[@"tests"][0][@"failure"][@"lineNumber"] should] beEqualTo:@100];
    [[results[@"tests"][0][@"failure"][@"reason"] should] beEqualTo:@"general failure"];
}

- (void)testWhenOneTestFailsAddsNameAndReason
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:nil results:results];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"the great test"] name];
    NSException *exception = [[NSException alloc] initWithName:NSInternalInconsistencyException reason:@"general failure" userInfo:nil];
    [accumulator testDidFail:test withException:exception];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"failure"][@"reason"] should] beEqualTo:@"general failure"];
}

- (void)testWhenTwoTestsFailsAddsNamesAndFilePathsAndLineNumbersAndReasons
{
    // given
    NSMutableDictionary *results = [@{@"tests": [[NSMutableArray alloc] init]} mutableCopy];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:nil results:results];
    
    // when
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    [@[@"the great test", @"the other great test"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        tests[idx] = [OCMockObject niceMockForClass:[INLTest class]];
        [[[tests[idx] stub] andReturn:name] name];
        NSDictionary *info = @{SenTestFilenameKey: @"SomeFile.m", SenTestLineNumberKey: @(idx)};
        NSException *exception = [[NSException alloc] initWithName:NSInternalInconsistencyException reason:@"general failure" userInfo:info];
        [accumulator testDidFail:tests[idx] withException:exception];
    }];
    
    // then
    [[results[@"tests"][0][@"name"] should] beEqualTo:@"the great test"];
    [[results[@"tests"][0][@"failure"][@"filePath"] should] beEqualTo:@"SomeFile.m"];
    [[results[@"tests"][0][@"failure"][@"lineNumber"] should] beEqualTo:@0];
    [[results[@"tests"][0][@"failure"][@"reason"] should] beEqualTo:@"general failure"];
    [[results[@"tests"][1][@"name"] should] beEqualTo:@"the other great test"];
    [[results[@"tests"][1][@"failure"][@"filePath"] should] beEqualTo:@"SomeFile.m"];
    [[results[@"tests"][1][@"failure"][@"lineNumber"] should] beEqualTo:@1];
    [[results[@"tests"][1][@"failure"][@"reason"] should] beEqualTo:@"general failure"];
}

- (void)testWhenRunFinishesAddsFinishDate
{
    // given
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    id dateProvider = [OCMockObject niceMockForClass:[INLDateProvider class]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[[dateProvider stub] andReturn:date] currentDate];
    INLResultAccumulator *accumulator = [[INLResultAccumulator alloc] initWithDateProvider:dateProvider results:results];
    
    // when
    [accumulator runDidFinish];
    
    // then
    [[@(results[@"finishDate"] != nil) should] beTrue];
    [[results[@"finishDate"] should] beEqualTo:date];
}

@end
