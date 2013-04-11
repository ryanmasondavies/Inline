//
//  INLResultAccumulator.h
//  Inline
//
//  Created by Ryan Davies on 11/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "INLResponder.h"
@class INLDateProvider;

/** Responds to events during a run and adds them to a dictionary. */
@interface INLResultAccumulator : NSObject <INLResponder>

/**
 Initialize a result accumulator.
 @param dateProvider An object used to retrieve the current date.
 @param results The results dictionary to add results to.
 @return An initialized result accumulator.
 */
- (id)initWithDateProvider:(INLDateProvider *)dateProvider results:(NSMutableDictionary *)results;

@end
