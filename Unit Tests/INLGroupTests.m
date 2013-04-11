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

- (void)testNotifiesResponderThatGroupHasStartedBeforeForwardingRunToComponents
{
    // given
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwardedRunToComponents = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedRunToComponents = YES; }] runWithResponder:responder];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwardedRunToComponents) should] beFalse]; }] groupDidStart:group];
    
    // when
    [group runWithResponder:responder];
    
    // then
    [responder verify];
}

- (void)testForwardsRunToEachComponent
{
    // given
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSMutableArray *order = [[NSMutableArray alloc] init];
    [@[@1, @2, @3] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        id component = [OCMockObject mockForProtocol:@protocol(INLComponent)];
        [[[component stub] andDo:^(NSInvocation *inv) { [order addObject:value]; }] runWithResponder:nil];
        [components addObject:component];
    }];
    CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:components sortDescriptors:@[]];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:sorted weight:nil];
    
    // when
    [group runWithResponder:nil];
    
    // then
    [[order should] beEqualTo:@[@1, @2, @3]];
}

- (void)testNotifiesResponderThatGroupHasFinishedAfterForwardingRunToComponents
{
    // given
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id components = [[CBDSortedArray alloc] initWithObjects:[@[component] mutableCopy] sortDescriptors:nil];
    INLGroup *group = [[INLGroup alloc] initWithName:nil components:components weight:nil];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwardedRunToComponents = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwardedRunToComponents = YES; }] runWithResponder:responder];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwardedRunToComponents) should] beTrue]; }] groupDidFinish:group];
    
    // when
    [group runWithResponder:responder];
    
    // then
    [responder verify];
}

@end
