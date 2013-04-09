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
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwardedReportersToComponents = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedReportersToComponents = YES; }] runWithReporter:reporter];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwardedReportersToComponents) should] beFalse]; }] groupDidStart:group];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [reporter verify];
}

- (void)testForwardsRunToEachComponent
{
    // given
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id component = [OCMockObject mockForProtocol:@protocol(INLComponent)];
        [[[component stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] runWithReporter:reporter];
        [components addObject:component];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:components sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:sorted weight:nil];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testNotifiesReporterThatGroupHasFinishedAfterForwardingRunToComponents
{
    // given
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwardedReportersToComponents = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedReportersToComponents = YES; }] runWithReporter:reporter];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwardedReportersToComponents) should] beTrue]; }] groupDidFinish:group];
    
    // when
    [group runWithReporter:reporter];
    
    // then
    [reporter verify];
}

@end
