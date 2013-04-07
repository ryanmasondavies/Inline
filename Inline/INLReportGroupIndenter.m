//
//  INLReportGroupIndenter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReportGroupIndenter.h"
#import "INLGroup.h"
#import "INLHook.h"
#import "INLTest.h"

@interface INLReportGroupIndenter ()
@property (strong, nonatomic) NSMutableString *output;
@property (nonatomic) NSUInteger indentationLevel;
@end

@implementation INLReportGroupIndenter

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
//    if ([[group label] isEqualToString:@""]) return;
    for (NSUInteger i = 0; i < [self indentationLevel]; i ++) [[self output] appendString:@"\t"];
    [self setIndentationLevel:[self indentationLevel] + 1];
}

- (void)willRunTest:(INLTest *)test
{
}

- (void)didRunTest:(INLTest *)test
{
}

- (void)didLeaveGroup:(INLGroup *)group
{
    [self setIndentationLevel:[self indentationLevel] - 1];
}

@end
