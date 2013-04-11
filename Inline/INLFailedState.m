//
//  INLFailedState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLFailedState.h"
#import "INLResponder.h"
#import "INLTest.h"

@interface INLFailedState ()
@property (copy, nonatomic) NSString *name;
@end

@implementation INLFailedState

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
