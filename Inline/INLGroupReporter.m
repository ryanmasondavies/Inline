//
//  INLGroupWriter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroupReporter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLGroupReporter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLGroupReporter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
    }
    return self;
}

- (void)groupDidStart:(INLGroup *)group
{
    [[self output] appendString:[group name]];
}

- (void)testDidStart:(INLTest *)test
{
}

- (void)testDidPass:(INLTest *)test
{
}

- (void)testDidSkip:(INLTest *)test
{
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
}

- (void)groupDidFinish:(INLGroup *)group
{
}

@end
