//
//  INLReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLReporterTests : SenTestCase

@end

@implementation INLReporterTests

- (void)testWhenNotNestedDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [reporter willRunTest:test];
    [reporter didRunTest:test];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedInBlankGroupDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[group stub] andReturn:@""] label];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [reporter didEnterGroup:group];
    [reporter willRunTest:test];
    [reporter didRunTest:test];
    [reporter didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedOnceIndentsTestOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[group stub] andReturn:@"group"] label];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [reporter didEnterGroup:group];
    [reporter willRunTest:test];
    [reporter didRunTest:test];
    [reporter didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\n"];
}

- (void)testWhenNestedTwiceIndentsTestTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) {
        groups[i] = [OCMockObject niceMockForClass:[INLGroup class]];
        [[[groups[i] stub] andReturn:@"group"] label];
    }
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [reporter didEnterGroup:groups[0]];
    [reporter didEnterGroup:groups[1]];
    [reporter willRunTest:test];
    [reporter didRunTest:test];
    [reporter didLeaveGroup:groups[1]];
    [reporter didLeaveGroup:groups[0]];
    
    // then
    [[output should] beEqualTo:@"group\n\tgroup\n\t\ttest\n"];
}

- (void)testWhenUnnestedGroupComesAfterNestedTestDoesNotIndent
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:@"group"] label];
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) {
        tests[i] = [OCMockObject niceMockForClass:[INLTest class]];
        [[[tests[i] stub] andReturn:@"test"] label];
    }
    
    // when
    [reporter didEnterGroup:group];
    [reporter willRunTest:tests[0]];
    [reporter didRunTest:tests[0]];
    [reporter didLeaveGroup:group];
    [reporter didEnterGroup:tests[1]];
    [reporter didLeaveGroup:tests[1]];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\ntest\n"];
}

@end
