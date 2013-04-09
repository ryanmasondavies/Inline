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

- (void)testWhenGroupStartsWritesGroupDidStartToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[formatter expect] writeGroupDidStart:group toReport:report];
    [reporter groupDidStart:group];
    
    // then
    [formatter verify];
}

- (void)testWhenGroupFinishesWritesGroupDidFinishToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[formatter expect] writeGroupDidFinish:group toReport:report];
    [reporter groupDidFinish:group];
    
    // then
    [formatter verify];
}

- (void)testWhenTestStartsWritesTestDidStartToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[formatter expect] writeTestDidStart:test toReport:report];
    [reporter testDidStart:test];
    
    // then
    [formatter verify];
}

- (void)testWhenTestPassesWritesTestDidPassToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[formatter expect] writeTestDidPass:test withDuration:5 toReport:report];
    [reporter testDidPass:test withDuration:5];
    
    // then
    [formatter verify];
}

- (void)testWhenTestSkipsWritesTestDidSkipToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[formatter expect] writeTestDidSkip:test toReport:report];
    [reporter testDidSkip:test];
    
    // then
    [formatter verify];
}

- (void)testWhenTestFailsWritesTestDidFailToReportUsingFormatter
{
    // given
    NSMutableString *report = [[NSMutableString alloc] init];
    id formatter = [OCMockObject niceMockForProtocol:@protocol(INLFormatter)];
    INLReporter *reporter = [[INLReporter alloc] initWithFormatter:formatter publisher:nil report:report];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    id exception = [[NSException alloc] initWithName:@"" reason:nil userInfo:nil];
    [[formatter expect] writeTestDidFail:test withException:exception toReport:report];
    [reporter testDidFail:test withException:exception];
    
    // then
    [formatter verify];
}


@end
