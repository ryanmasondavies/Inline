//
//  INLReadyState.m
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReadyState.h"

@interface INLReadyState ()
@property (strong, nonatomic) INLTestBlock block;
@property (copy, nonatomic) NSString *label;
@end

@implementation INLReadyState

- (id)initWithBlock:(INLTestBlock)block label:(NSString *)label
{
    if (self = [self init]) {
        [self setBlock:block];
        [self setLabel:label];
    }
    return self;
}

- (void)runForTest:(INLTest *)test
{
    [self block]();
}

- (NSString *)description
{
    return [self label];
}

@end
