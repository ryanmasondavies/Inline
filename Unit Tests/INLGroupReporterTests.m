//
//  INLGroupReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupReporterTests : SenTestCase

@end

@implementation INLGroupReporterTests

- (void)testWhenGroupStartsOutputsGroupName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupReporter *reporter = [[INLGroupReporter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:@"group"] name];
    
    // when
    [reporter groupDidStart:group];
    
    // then
    [[output should] beEqualTo:@"group"];
}

@end
