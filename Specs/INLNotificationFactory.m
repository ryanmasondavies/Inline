//
//  INLNotificationFactory.m
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNotificationFactory.h"

@implementation INLNotificationFactory

+ (NSNotification *)createNotificationNamed:(NSString *)notificationName forSuiteNamed:(NSString *)suiteName
{
    NSInvocation  *invocation = [NSInvocation invocationWithMethodSignature:[NSNull instanceMethodSignatureForSelector:@selector(init)]];
    SenTestCase   *testCase   = [OCMockObject mockForClass:[SenTestCase class]];
    SenTestRun    *run        = [[SenTestRun alloc] initWithTest:testCase];
    [[[(id)testCase stub] andReturn:invocation] invocation];
    [[[(id)testCase stub] andReturn:suiteName] name];
    return [NSNotification notificationWithName:notificationName object:run];
}

+ (NSNotification *)createNotificationNamed:(NSString *)name forTest:(INLTest *)test
{
    INLInvocation  *invocation = [INLInvocation invocationWithTest:test];
    SenTestCase    *testCase   = [[INLTestCase alloc] initWithInvocation:invocation];
    SenTestRun     *run        = [[SenTestRun alloc] initWithTest:testCase];
    return [NSNotification notificationWithName:name object:run];
}

+ (NSNotification *)createNotificationNamed:(NSString *)name forTest:(INLTest *)test thatFailsWithException:(NSException *)exception
{
    INLInvocation  *invocation   = [INLInvocation invocationWithTest:test];
    SenTestCase    *testCase     = [[INLTestCase alloc] initWithInvocation:invocation];
    SenTestRun     *run          = [OCMockObject partialMockForObject:[[SenTestRun alloc] initWithTest:testCase]];
    NSDictionary *info = (exception) ? @{@"exception" : exception} : nil;
    [[[(id)run stub] andReturnValue:OCMOCK_VALUE((BOOL){NO})] hasSucceeded];
    return [NSNotification notificationWithName:name object:run userInfo:info];
}

+ (NSNotification *)createNotificationNamed:(NSString *)name forTestCase:(SenTestCase *)testCase
{
    SenTestRun *run = [[SenTestRun alloc] initWithTest:testCase];
    return [NSNotification notificationWithName:name object:run];
}

+ (NSNotification *)createNotificationNamed:(NSString *)name forTestCase:(SenTestCase *)testCase thatFailsWithException:(NSException *)exception
{
    SenTestRun *run = [OCMockObject partialMockForObject:[[SenTestRun alloc] initWithTest:testCase]];
    NSDictionary *info = (exception) ? @{@"exception" : exception} : nil;
    [[[(id)run stub] andReturnValue:OCMOCK_VALUE((BOOL){NO})] hasSucceeded];
    return [NSNotification notificationWithName:name object:run userInfo:info];
}

@end
