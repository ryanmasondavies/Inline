//
//  INLRunnerTests.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLRunnerTests : SenTestCase

@end

@implementation INLRunnerTests

- (void)testNotifiesResponderThatRunHasStartedBeforeForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithResponder:OCMOCK_ANY];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beFalse]; }] runDidStart];
    [runner runComponent:component withResponder:responder];
    
    // then
    [responder verify];
}

- (void)testForwardsRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    [[component expect] runWithResponder:OCMOCK_ANY];
    [runner runComponent:component withResponder:nil];
    
    // then
    [component verify];
}

- (void)testPassesResponderToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    [[component expect] runWithResponder:responder];
    [runner runComponent:component withResponder:responder];
    
    // then
    [component verify];
}

- (void)testNotifiesResponderThatRunHasFinishedAfterForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id responder = [OCMockObject niceMockForProtocol:@protocol(INLResponder)];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithResponder:OCMOCK_ANY];
    [[[responder expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beTrue]; }] runDidFinish];
    [runner runComponent:component withResponder:responder];
    
    // then
    [responder verify];
}

@end
