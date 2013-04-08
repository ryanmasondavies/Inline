//
//  INLGroupIndenterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupIndenterTests : SenTestCase

@end

@implementation INLGroupIndenterTests

- (void)testWhenGroupStartsWhenNotNestedDoesNotIndentGroupName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupIndenter *indenter = [[INLGroupIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@""];
}

- (void)testWhenGroupStartsWhenNestedOnceIndentsGroupNameOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupIndenter *indenter = [[INLGroupIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    [indenter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\t"];
}

- (void)testWhenGroupStartsWhenNestedTwiceIndentsGroupNameTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupIndenter *indenter = [[INLGroupIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    [indenter groupDidStart:nil];
    [indenter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@"\t\t\t"];
}

- (void)testWhenGroupStartsNotNestedAfterNestingOnceDoesNotIndentGroupName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupIndenter *indenter = [[INLGroupIndenter alloc] initWithOutput:output];
    
    // when
    [indenter groupDidStart:nil];
    [indenter groupDidFinish:nil];
    [indenter groupDidStart:nil];
    
    // then
    [[output should] beEqualTo:@""];
}

@end
