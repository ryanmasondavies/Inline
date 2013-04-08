//
//  INLNewlineWriterTests.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNewlineWriterTests : SenTestCase

@end

@implementation INLNewlineWriterTests

- (void)testWhenEnteringGroupOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestPassesOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidPass:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestSkipsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidSkip:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestFailsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer testDidFail:nil withException:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

@end
