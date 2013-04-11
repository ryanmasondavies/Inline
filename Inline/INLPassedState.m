//
//  INLPassedState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLPassedState.h"
#import "INLResponder.h"
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

- (void)runWithResponder:(id<INLResponder>)responder forTest:(INLTest *)test
{
}

@end
