//
//  INLNodeWriterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNodeWriterTests : SenTestCase

@end

@implementation INLNodeWriterTests

- (void)testWhenNotNestedDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNodeWriter *writer = [[INLNodeWriter alloc] initWithOutput:output];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    
    // when
    [writer willRunTest:test];
    [writer didRunTest:test];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedInBlankGroupDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNodeWriter *writer = [[INLNodeWriter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLGroup *)[[group stub] andReturn:@""] name];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    
    // when
    [writer didEnterGroup:group];
    [writer willRunTest:test];
    [writer didRunTest:test];
    [writer didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedOnceIndentsTestOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNodeWriter *writer = [[INLNodeWriter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLGroup *)[[group stub] andReturn:@"group"] name];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    
    // when
    [writer didEnterGroup:group];
    [writer willRunTest:test];
    [writer didRunTest:test];
    [writer didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\n"];
}

- (void)testWhenNestedTwiceIndentsTestTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNodeWriter *writer = [[INLNodeWriter alloc] initWithOutput:output];
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) {
        groups[i] = [OCMockObject niceMockForClass:[INLGroup class]];
        [(INLGroup *)[[groups[i] stub] andReturn:@"group"] name];
    }
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [(INLTest *)[[test stub] andReturn:@"test"] name];
    
    // when
    [writer didEnterGroup:groups[0]];
    [writer didEnterGroup:groups[1]];
    [writer willRunTest:test];
    [writer didRunTest:test];
    [writer didLeaveGroup:groups[1]];
    [writer didLeaveGroup:groups[0]];
    
    // then
    [[output should] beEqualTo:@"group\n\tgroup\n\t\ttest\n"];
}

- (void)testWhenUnnestedGroupComesAfterNestedTestDoesNotIndent
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLNodeWriter *writer = [[INLNodeWriter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [(INLGroup *)[[group stub] andReturn:@"group"] name];
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) {
        tests[i] = [OCMockObject niceMockForClass:[INLTest class]];
        [(INLTest *)[[tests[i] stub] andReturn:@"test"] name];
    }
    
    // when
    [writer didEnterGroup:group];
    [writer willRunTest:tests[0]];
    [writer didRunTest:tests[0]];
    [writer didLeaveGroup:group];
    [writer didEnterGroup:tests[1]];
    [writer didLeaveGroup:tests[1]];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\ntest\n"];
}

@end
