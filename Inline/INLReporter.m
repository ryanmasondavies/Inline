//
//  INLReporter.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLReporter.h"
#import "INLDateProvider.h"
#import "INLPublisher.h"
#import "INLGroup.h"
#import "INLTest.h"

@interface INLReporter ()
@property (strong, nonatomic) INLDateProvider *dateProvider;
@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) id<INLPublisher> publisher;
@end

@implementation INLReporter

- (id)initWithDateProvider:(INLDateProvider *)dateProvider publisher:(id<INLPublisher>)publisher results:(NSMutableDictionary *)results
{
    if (self = [self init]) {
        [self setDateProvider:dateProvider];
        [self setPublisher:publisher];
        [self setResults:results];
    }
    return self;
}

@end
