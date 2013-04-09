//
//  INLGroup.m
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLGroup.h"
#import "INLReporter.h"

@interface INLGroup ()
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) CBDSortedArray *components;
@property (copy, nonatomic) NSNumber *weight;
@end

@implementation INLGroup

- (id)initWithName:(NSString *)name components:(CBDSortedArray *)components weight:(NSNumber *)weight
{
    if (self = [super init]) {
        [self setName:name];
        [self setComponents:components];
        [self setWeight:weight];
    }
    return self;
}

- (void)runWithReporter:(INLReporter *)reporter
{
    [reporter groupDidStart:self];
    [[self components] enumerateObjectsUsingBlock:^(id<INLComponent> component, NSUInteger idx, BOOL *stop) {
        [component runWithReporter:reporter];
    }];
    [reporter groupDidFinish:self];
}

@end
