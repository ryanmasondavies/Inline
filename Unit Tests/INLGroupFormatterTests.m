//
//  INLGroupFormatterTests.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupFormatterTests : SenTestCase

@end

@implementation INLGroupFormatterTests

- (void)testWhenGroupStartsOutputsGroupName
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLGroupFormatter *formatter = [[INLGroupFormatter alloc] initWithOutput:output];
    id group = [OCMockObject niceMockForClass:[INLGroup class]];
    [[[group stub] andReturn:@"group"] name];
    
    // when
    [formatter groupDidStart:group];
    
    // then
    [[output should] beEqualTo:@"group"];
}

@end
