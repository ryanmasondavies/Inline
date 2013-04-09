//
//  INLTextFormatterTests.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLTextFormatterTests : SenTestCase

@end

@implementation INLTextFormatterTests

- (void)testWhenGroupStartsWritesGroupName
{
    // given
    INLTextFormatter *formatter = [[INLTextFormatter alloc] init];
    
    // when
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:@"group"] name];
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeGroupDidStart:group toReport:report];
    
    // then
    [[report should] beEqualTo:@"group"];
}

- (void)testWhenTestPassesWritesTestName
{
    // given
    INLTextFormatter *formatter = [[INLTextFormatter alloc] init];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] name];
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeTestDidPass:test withDuration:0 toReport:report];
    
    // then
    [[report should] beEqualTo:@"test"];
}

- (void)testWhenTestSkipsWritesTestName
{
    // given
    INLTextFormatter *formatter = [[INLTextFormatter alloc] init];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] name];
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeTestDidSkip:test toReport:report];
    
    // then
    [[report should] beEqualTo:@"test"];
}

- (void)testWhenTestFailsWritesTestName
{
    // given
    INLTextFormatter *formatter = [[INLTextFormatter alloc] init];
    
    // when
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] name];
    NSMutableString *report = [[NSMutableString alloc] init];
    [formatter writeTestDidFail:test withException:nil toReport:report];
    
    // then
    [[report should] beEqualTo:@"test"];
}

@end
