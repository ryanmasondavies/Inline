//
//  INLTestNameIndenter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestNameIndenter.h"
#import "INLGroup.h"
#import "INLHook.h"
#import "INLTest.h"

@interface INLTestNameIndenter ()
@property (strong, nonatomic) NSMutableString *output;
@property (nonatomic) NSUInteger indentationLevel;
@end

@implementation INLTestNameIndenter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
        [self setIndentationLevel:0];
    }
    return self;
}

- (void)didEnterGroup:(INLGroup *)group
{
    [self setIndentationLevel:[self indentationLevel] + 1];
}

- (void)willRunTest:(INLTest *)test
{
}

- (void)didRunTest:(INLTest *)test
{
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
}

- (void)didLeaveGroup:(INLGroup *)group
{
    [self setIndentationLevel:[self indentationLevel] - 1];
}

@end
