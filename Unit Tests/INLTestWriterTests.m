//
//  INLTestWriterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestWriterTests : SenTestCase

@end

@implementation INLTestWriterTests

- (void)testWhenTestPassesOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestWriter *writer = [[INLTestWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidPass:test];
    
    // then
    [[output should] beEqualTo:@"test"];
}

- (void)testWhenTestSkipsOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestWriter *writer = [[INLTestWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidSkip:test];
    
    // then
    [[output should] beEqualTo:@"test"];
}

- (void)testWhenTestFailsOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestWriter *writer = [[INLTestWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidFail:test withException:nil];
    
    // then
    [[output should] beEqualTo:@"test"];
}

@end
