//
//  INLGroupWriterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupWriterTests : SenTestCase

@end

@implementation INLGroupWriterTests

- (void)testWhenEnteringGroupOutputsGroupName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupWriter *writer = [[INLGroupWriter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:@"group"] name];
    
    // when
    [writer didEnterGroup:group];
    
    // then
    [[output should] beEqualTo:@"group"];
}

@end
