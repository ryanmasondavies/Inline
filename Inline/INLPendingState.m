//
//  INLPendingState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLPendingState.h"

@interface INLPendingState ()
@property (copy, nonatomic) NSString *label;
@end

@implementation INLPendingState

- (id)initWithLabel:(NSString *)label
{
    if (self = [self init]) {
        [self setLabel:label];
    }
    return self;
}

- (void)runForTest:(INLTest *)test
{
}

- (void)setReason:(NSString *)reason
{
}

@end
