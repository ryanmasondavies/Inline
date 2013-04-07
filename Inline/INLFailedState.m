//
//  INLFailedState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLFailedState.h"

@interface INLFailedState ()
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *reason;
@end

@implementation INLFailedState

- (id)initWithName:(NSString *)name reason:(NSString *)reason
{
    if (self = [self init]) {
        [self setName:name];
        [self setReason:reason];
    }
    return self;
}

- (void)runForTest:(INLTest *)test
{
}

@end
