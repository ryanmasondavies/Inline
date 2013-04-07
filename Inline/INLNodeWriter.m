//
//  INLNodeWriter.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNodeWriter.h"
#import "INLGroup.h"
#import "INLHook.h"
#import "INLTest.h"

@interface INLNodeWriter ()
@property (strong, nonatomic) NSMutableString *output;
@property (nonatomic) NSUInteger indentationLevel;
@end

@implementation INLNodeWriter

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
    if ([[group label] isEqualToString:@""]) return;
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [[self output] appendString:[group label]];
    [[self output] appendString:@"\n"];
    [self setIndentationLevel:[self indentationLevel] + 1];
}

- (void)willRunTest:(INLTest *)test
{
}

- (void)didRunTest:(INLTest *)test
{
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [[self output] appendString:[test label]];
    [[self output] appendString:@"\n"];
}

- (void)didLeaveGroup:(INLGroup *)group
{
    [self setIndentationLevel:[self indentationLevel] - 1];
}

@end
