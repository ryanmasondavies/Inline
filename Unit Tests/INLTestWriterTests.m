//
//  INLTestWriterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNodeWriterTests : SenTestCase

@end

@implementation INLNodeWriterTests

- (void)testAfterRunningTestOutputsTestName
{
    // given
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestWriter *writer = [[INLTestWriter alloc] initWithOutput:output];
    
    // when
    [writer didRunTest:test];
    
    // then
    [[output should] beEqualTo:@"test"];
}

@end
