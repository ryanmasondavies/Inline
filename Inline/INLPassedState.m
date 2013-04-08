//
//  INLPassedState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLPassedState.h"
#import "INLReporter.h"
#import "INLTest.h"

@interface INLPassedState ()
@property (copy, nonatomic) NSString *name;
@end

@implementation INLPassedState

- (id)initWithName:(NSString *)name
{
    if (self = [self init]) {
        [self setName:name];
    }
    return self;
}

- (void)runWithReporter:(id<INLReporter>)reporter forTest:(INLTest *)test
{
}

@end
