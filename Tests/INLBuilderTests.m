//
//  INLBuilderTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLBuilderTests : SenTestCase

@end

@implementation INLBuilderTests

- (void)testHasRootGroup
{
    INLBuilder *builder = [[INLBuilder alloc] init];
    [[[builder rootGroup] should] beKindOfClass:[INLGroup class]];
}

@end
