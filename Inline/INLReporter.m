//
//  INLReporter.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReporter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLReporter ()
@property (strong, nonatomic) NSMutableString *output;
@property (nonatomic) NSUInteger indentationLevel;
@end

@implementation INLReporter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
        [self setIndentationLevel:0];
    }
    return self;
}

- (void)enterGroup:(INLGroup *)group
{
    if ([[group description] isEqualToString:@""]) return;
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [[self output] appendString:[group description]];
    [[self output] appendString:@"\n"];
    [self setIndentationLevel:[self indentationLevel] + 1];
}

- (void)visitTest:(INLTest *)test
{
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [[self output] appendString:[test description]];
    [[self output] appendString:@"\n"];
}

- (void)visitHook:(INLHook *)hook
{
}

- (void)leaveGroup:(INLGroup *)group
{
    [self setIndentationLevel:[self indentationLevel] - 1];
}

@end
