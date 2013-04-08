//
//  INLTestReporter.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestReporter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLTestReporter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLTestReporter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
    }
    return self;
}

- (void)groupDidStart:(INLGroup *)group
{
}

- (void)testDidStart:(INLTest *)test
{
}

- (void)testDidPass:(INLTest *)test
{
    [[self output] appendString:[test name]];
}

- (void)testDidSkip:(INLTest *)test
{
    [[self output] appendString:[test name]];
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
    [[self output] appendString:[test name]];
}

- (void)groupDidFinish:(INLGroup *)group
{
}

@end
