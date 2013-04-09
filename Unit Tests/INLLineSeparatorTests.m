//
//  INLLineSeparatorTests.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLLineSeparatorTests : SenTestCase

@end

@implementation INLLineSeparatorTests

- (void)testWhenEnteringGroupOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLLineSeparator *formatter = [[INLLineSeparator alloc] initWithOutput:output];
    
    // when
    [formatter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestPassesOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLLineSeparator *formatter = [[INLLineSeparator alloc] initWithOutput:output];
    
    // when
    [formatter testDidPass:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestSkipsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLLineSeparator *formatter = [[INLLineSeparator alloc] initWithOutput:output];
    
    // when
    [formatter testDidSkip:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestFailsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLLineSeparator *formatter = [[INLLineSeparator alloc] initWithOutput:output];
    
    // when
    [formatter testDidFail:nil withException:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

@end
