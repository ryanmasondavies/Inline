//
//  INLNewlineFormatterTests.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNewlineFormatterTests : SenTestCase

@end

@implementation INLNewlineFormatterTests

- (void)testWhenEnteringGroupOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineFormatter *formatter = [[INLNewlineFormatter alloc] initWithOutput:output];
    
    // when
    [formatter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestPassesOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineFormatter *formatter = [[INLNewlineFormatter alloc] initWithOutput:output];
    
    // when
    [formatter testDidPass:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestSkipsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineFormatter *formatter = [[INLNewlineFormatter alloc] initWithOutput:output];
    
    // when
    [formatter testDidSkip:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestFailsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineFormatter *formatter = [[INLNewlineFormatter alloc] initWithOutput:output];
    
    // when
    [formatter testDidFail:nil withException:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

@end
