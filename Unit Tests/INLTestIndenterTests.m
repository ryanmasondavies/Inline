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

- (void)testWhenNotNestedDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [indenter willRunTest:test];
    [indenter didRunTest:test];
    
    // then
    [[output should] beEqualTo:@""];
}

- (void)testWhenNestedOnceIndentsTestOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[group stub] andReturn:@"group"] label];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [indenter didEnterGroup:group];
    [indenter willRunTest:test];
    [indenter didRunTest:test];
    [indenter didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"\t"];
}

- (void)testWhenNestedTwiceIndentsTestTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[group stub] andReturn:@"group"] label];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [indenter didEnterGroup:group];
    [indenter didEnterGroup:group];
    [indenter willRunTest:test];
    [indenter didRunTest:test];
    [indenter didLeaveGroup:group];
    [indenter didLeaveGroup:group];
    
    // then
    [[output should] beEqualTo:@"\t\t"];
}

- (void)testWhenUnnestedGroupComesAfterNestedTestDoesNotIndent
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLTestIndenter *indenter = [[INLTestIndenter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    id test = [OCMockObject niceMockForClass:[INLTest class]];
    [[[group stub] andReturn:@"group"] label];
    [[[test stub] andReturn:@"test"] label];
    
    // when
    [indenter didEnterGroup:group];
    [indenter willRunTest:test];
    [indenter didRunTest:test];
    [indenter didLeaveGroup:group];
    [indenter didEnterGroup:test];
    [indenter didLeaveGroup:test];
    
    // then
    [[output should] beEqualTo:@"\t"];
}

@end
