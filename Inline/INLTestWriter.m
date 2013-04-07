//
//  INLTestWriter.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestWriter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLTestWriter ()
@property (strong, nonatomic) NSMutableString *output;
@end

@implementation INLTestWriter

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
    [[self output] appendString:[test name]];
}

- (void)didLeaveGroup:(INLGroup *)group
{
}

@end
