//
//  INLTestReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestReporterTests : SenTestCase

@end

@implementation INLTestReporterTests

- (void)testWhenTestPassesOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestReporter *reporter = [[INLTestReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidPass:test];
    
    // then
    [[output should] beEqualTo:@"test"];
}

- (void)testWhenTestSkipsOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestReporter *reporter = [[INLTestReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidSkip:test];
    
    // then
    [[output should] beEqualTo:@"test"];
}

- (void)testWhenTestFailsOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestReporter *reporter = [[INLTestReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidFail:test withException:nil];
    
    // then
    [[output should] beEqualTo:@"test"];
}

@end
