//
//  INLGroupTests.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLGroupTests : SenTestCase

@end

@implementation INLGroupTests

- (void)testTellsVisitorToEnterGroupBeforeForwardingVisitsToNodes
{
    // given
    id node = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id nodes = [[CBDSortedArray alloc] initWithObjects:[@[node] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:nodes weight:nil];
    id visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    __block BOOL forwardedVisitsToNodes = NO;
    [[[node stub] andDo:^(NSInvocation *i) { forwardedVisitsToNodes = YES; }] acceptVisitor:visitor];
    [[[visitor expect] andDo:^(NSInvocation *i) { [[@(forwardedVisitsToNodes) should] beFalse]; }] enterGroup:group];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

- (void)testForwardsVisitsToEachNode
{
    // given
    id<INLVisitor> visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id node = [OCMockObject mockForProtocol:@protocol(INLNode)];
        [[[node stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] acceptVisitor:visitor];
        [nodes addObject:node];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:sorted weight:nil];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testTellsVisitorToLeaveGroupAfterForwardingVisitsToNodes
{
    // given
    id node = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id nodes = [[CBDSortedArray alloc] initWithObjects:[@[node] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:nodes weight:nil];
    id visitor = [OCMockObject niceMockForProtocol:@protocol(INLVisitor)];
    __block BOOL forwardedVisitsToNodes = NO;
    [[[node stub] andDo:^(NSInvocation *i) { forwardedVisitsToNodes = YES; }] acceptVisitor:visitor];
    [[[visitor expect] andDo:^(NSInvocation *i) { [[@(forwardedVisitsToNodes) should] beTrue]; }] leaveGroup:group];
    
    // when
    [group acceptVisitor:visitor];
    
    // then
    [visitor verify];
}

@end
