//
//  INLPendingState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLPendingState.h"
#import "INLResponder.h"
#import "INLTest.h"

@interface INLPendingState ()
@property (copy, nonatomic) NSString *name;
@end

@implementation INLPendingState

- (id)initWithName:(NSString *)name
{
    if (self = [self init]) {
        [self setName:name];
    }
    return self;
}

- (void)runWithResponder:(id<INLResponder>)responder forTest:(INLTest *)test
{
    [responder testDidSkip:test];
}

@end
