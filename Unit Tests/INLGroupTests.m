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

- (void)testNotifiesReporterThatGroupHasStartedBeforeForwardingRunToComponents
{
    // given
    id node = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id nodes = [[CBDSortedArray alloc] initWithObjects:[@[node] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:nodes weight:nil];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwardedReportersToNodes = NO;
    [[[node stub] andDo:^(NSInvocation *i) { forwardedReportersToNodes = YES; }] runWithReporter:reporter];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwardedReportersToNodes) should] beFalse]; }] groupDidStart:group];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [reporter verify];
}

- (void)testForwardsRunToEachComponent
{
    // given
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id node = [OCMockObject mockForProtocol:@protocol(INLNode)];
        [[[node stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] runWithReporter:reporter];
        [nodes addObject:node];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:nodes sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:sorted weight:nil];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testNotifiesReporterThatGroupHasFinishedAfterForwardingRunToComponents
{
    // given
    id node = [OCMockObject niceMockForProtocol:@protocol(INLNode)];
    id nodes = [[CBDSortedArray alloc] initWithObjects:[@[node] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil nodes:nodes weight:nil];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwardedReportersToNodes = NO;
    [[[node stub] andDo:^(NSInvocation *i) { forwardedReportersToNodes = YES; }] runWithReporter:reporter];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwardedReportersToNodes) should] beTrue]; }] groupDidFinish:group];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [reporter verify];
}

@end
