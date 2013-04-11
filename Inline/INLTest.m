//
//  INLTest.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTest.h"
#import "INLTestState.h"
#import "INLResponder.h"

@interface INLTest ()
@property (strong, nonatomic) id<INLTestState> state;
@property (copy, nonatomic) NSNumber *weight;
@end

@implementation INLTest

- (id)initWithState:(id<INLTestState>)state weight:(NSNumber *)weight
{
    if (self = [self init]) {
        [self setState:state];
        [self setWeight:weight];
    }
    return self;
}

- (void)transitionToState:(id<INLTestState>)state
{
    [self setState:state];
}

- (NSString *)name
{
    return [[self state] name];
}

- (void)runWithResponder:(id<INLResponder>)responder
{
    [[self state] runWithResponder:responder forTest:self];
}

@end
