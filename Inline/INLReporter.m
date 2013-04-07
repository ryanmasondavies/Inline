//
//  INLReporter.m
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReporter.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLReporter ()
@property (strong, nonatomic) NSArray *writers;
@end

@implementation INLReporter

- (id)initWithWriters:(NSArray *)writers
{
    if (self = [self init]) {
        [self setWriters:writers];
    }
    return self;
}

- (void)didEnterGroup:(INLGroup *)group
{
    [[self writers] makeObjectsPerformSelector:@selector(didEnterGroup:) withObject:group];
}

- (void)willRunTest:(INLTest *)test
{
    [[self writers] makeObjectsPerformSelector:@selector(willRunTest:) withObject:test];
}

- (void)didRunTest:(INLTest *)test
{
    [[self writers] makeObjectsPerformSelector:@selector(didRunTest:) withObject:test];
}

- (void)didLeaveGroup:(INLGroup *)group
{
    [[self writers] makeObjectsPerformSelector:@selector(didLeaveGroup:) withObject:group];
}

@end
