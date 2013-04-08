//
//  INLTestIndenterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTestIndenterTests : SenTestCase

@end

@implementation INLTestIndenterTests

- (void)testWhenTestStartsWhenNotNestedDoesNotIndentTestName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    
    // when
    [indenter testDidStart:nil];
    
    // then
    [[output should] beEqualTo:@""];
}

- (void)testWhenTestStartsWhenNestedOnceIndentsTestNameOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    [indenter testDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\t"];
}

- (void)testWhenTestStartsWhenNestedTwiceIndentsTestNameTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    [indenter groupDidStart:nil];
    [indenter testDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\t\t"];
}

- (void)testWhenTestStartsWhenNotNestedAfterNestingOnceDoesNotIndentTestName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] name];
    
    // when
    [indenter groupDidStart:test];
    [indenter groupDidFinish:test];
    [indenter testDidStart:test];
    
    // then
    [[output should] beEqualTo:@""];
}

@end
