//
//  INLObserver.m
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLObserver.h"
#import "INLReporter.h"

@implementation INLObserver

+ (void)load
{
    [[NSUserDefaults standardUserDefaults] setObject:@"INLObserver" forKey:SenTestObserverClassKey];
}

+ (id)activeReporter
{
    return self.reporters[0];
}

+ (void)setActiveReporter:(id <INLReporter>)reporter
{
    self.reporters[0] = reporter;
}

+ (NSMutableArray *)reporters
{
    // An array is used to potentially allow for muliple active reporters, though only one at a time is currently implemented.
    // It is also used so that setActiveReporter: and activeReporter have a shared, mutable access point to the same reporter instance.
    
    static NSMutableArray *reporters = nil;
    if (reporters == nil) reporters = [NSMutableArray array];
    return reporters;
}

+ (void)testSuiteDidStart:(NSNotification *)notification
{
}

+ (void)testCaseDidStop:(NSNotification *)notification
{
}

+ (void)testCaseDidFail:(NSNotification *)notification
{
}

+ (void)testSuiteDidStop:(NSNotification *)notification
{
}

@end
