//
//  INLGroupIndenter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroupIndenter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLGroupIndenter ()
@property (strong, nonatomic) NSMutableString *output;
@property (nonatomic) NSUInteger indentationLevel;
@end

@implementation INLGroupIndenter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
        [self setIndentationLevel:0];
    }
    return self;
}

- (void)groupDidStart:(INLGroup *)group
{
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [self setIndentationLevel:[self indentationLevel] + 1];
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
    [self setIndentationLevel:[self indentationLevel] - 1];
}

@end
