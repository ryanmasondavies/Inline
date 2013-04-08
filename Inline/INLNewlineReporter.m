//
//  INLNewlineReporter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNewlineReporter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLNewlineReporter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLNewlineReporter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
    }
    return self;
}

- (void)groupDidStart:(INLGroup *)group
{
    [[self output] appendString:@"\n"];
}

- (void)testDidStart:(INLTest *)test
{
}

- (void)testDidPass:(INLTest *)test
{
    [[self output] appendString:@"\n"];
}

- (void)testDidSkip:(INLTest *)test
{
    [[self output] appendString:@"\n"];
}

- (void)testDidFail:(INLTest *)test withException:(NSException *)exception
{
    [[self output] appendString:@"\n"];
}

- (void)groupDidFinish:(INLGroup *)group
{
}

@end
