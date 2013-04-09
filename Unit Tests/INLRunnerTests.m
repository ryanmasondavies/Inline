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

- (void)testNotifiesReporterThatRunHasStartedBeforeForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithReporter:OCMOCK_ANY];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beFalse]; }] runDidStart];
    [runner runComponent:component withReporter:reporter];
    
    // then
    [reporter verify];
}

- (void)testForwardsRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    [[component expect] runWithReporter:OCMOCK_ANY];
    [runner runComponent:component withReporter:nil];
    
    // then
    [component verify];
}

- (void)testPassesReporterToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    [[component expect] runWithReporter:reporter];
    [runner runComponent:component withReporter:reporter];
    
    // then
    [component verify];
}

- (void)testNotifiesReporterThatRunHasFinishedAfterForwardingRunToComponent
{
    // given
    INLRunner *runner = [[INLRunner alloc] init];
    
    // when
    id component = [OCMockObject niceMockForProtocol:@protocol(INLComponent)];
    id reporter = [OCMockObject niceMockForClass:[INLReporter class]];
    __block BOOL forwarded = NO;
    [[[component stub] andDo:^(NSInvocation *i) { forwarded = YES; }] runWithReporter:OCMOCK_ANY];
    [[[reporter expect] andDo:^(NSInvocation *i) { [[@(forwarded) should] beTrue]; }] runDidFinish];
    [runner runComponent:component withReporter:reporter];
    
    // then
    [reporter verify];
}

@end
