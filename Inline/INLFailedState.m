//
//  INLFailedState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLFailedState.h"

@interface INLFailedState ()
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) NSString *reason;
@end

@implementation INLFailedState

- (id)initWithLabel:(NSString *)label reason:(NSString *)reason
{
    if (self = [self init]) {
        [self setLabel:label];
        [self setReason:reason];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@)", [self label], [self reason]];
}

- (void)runForTest:(INLTest *)test
{
}

@end
