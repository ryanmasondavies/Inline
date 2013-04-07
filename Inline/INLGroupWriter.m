//
//  INLGroupWriter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroupWriter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLGroupWriter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLGroupWriter

- (id)initWithOutput:(NSMutableString *)output
{
    if (self = [self init]) {
        [self setOutput:output];
    }
    return self;
}

- (void)didEnterGroup:(INLGroup *)group
{
    [[self output] appendString:[group name]];
}

- (void)willRunTest:(INLTest *)test
{
}

- (void)didRunTest:(INLTest *)test
{
}

- (void)didLeaveGroup:(INLGroup *)group
{
}

@end
