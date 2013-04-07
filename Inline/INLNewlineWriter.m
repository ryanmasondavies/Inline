//
//  INLNewlineWriter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNewlineWriter.h"

@interface INLNewlineWriter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLNewlineWriter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
    }
    return self;
}

- (void)didEnterGroup:(INLGroup *)group
{
}

- (void)willRunTest:(INLTest *)test
{
}

- (void)didRunTest:(INLTest *)test
{
    [[self output] appendString:@"\n"];
}

- (void)didLeaveGroup:(INLGroup *)group
{
    [[self output] appendString:@"\n"];
}

@end
