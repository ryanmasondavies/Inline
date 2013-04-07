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

- (void)testWhenRanTestOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer didRunTest:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

- (void)testWhenLeavingGroupOutputsNewline
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNewlineWriter *writer = [[INLNewlineWriter alloc] initWithOutput:output];
    
    // when
    [writer didLeaveGroup:nil];
    
    // then
    [[output should] beEqualTo:@"\n"];
}

@end
