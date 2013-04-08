//
//  INLNewlineReporterTests.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNewlineReporterTests : SenTestCase

@end

@implementation INLNewlineReporterTests

- (void)testWhenEnteringGroupOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineReporter *reporter = [[INLNewlineReporter alloc] initWithOutput:output];
    
    // when
    [reporter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestPassesOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineReporter *reporter = [[INLNewlineReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidPass:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestSkipsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineReporter *reporter = [[INLNewlineReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidSkip:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenTestFailsOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineReporter *reporter = [[INLNewlineReporter alloc] initWithOutput:output];
    
    // when
    [reporter testDidFail:nil withException:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

@end
