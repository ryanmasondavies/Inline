//
//  INLNodeIteratorTests.m
//  Inline
//
//  Created by Ryan Davies on 19/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLNodeIteratorTests : SenTestCase

@end

@implementation INLNodeIteratorTests

- (void)test_WithThreeNodes_FirstHasLowestWeight
{
    // given
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    INLNodeIterator *nodeIterator = [[INLNodeIterator alloc] initWithNodes:nodes];
    [@[@5, @1, @10] enumerateObjectsUsingBlock:^(NSNumber *weight, NSUInteger idx, BOOL *stop) {
        nodes[idx] = [OCMockObject mockForProtocol:@protocol(INLNode)];
        [[[nodes[idx] stub] andReturn:weight] weight];
    }];
    
    // when
    id node = [nodeIterator first];
    
    // then
    [[@(node == nodes[1]) should] beTrue];
}

- (void)test_WithThreeNodes_NextReturnsNodeOfSecondLowestWeight
{
}

- (void)test_WithThreeNodes_NextTwiceReturnsNodeOfHighestWeight
{
}

- (void)test_WithThreeNodes_NextThriceReturnsNil
{
}

@end
