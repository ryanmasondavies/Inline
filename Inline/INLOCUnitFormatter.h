//
//  INLOCUnitFormatter.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLFormatter.h"
@class INLDateProvider;

/** A formatter which writes reporter events in the format used by OCUnit. */
@interface INLOCUnitFormatter : NSObject <INLFormatter>

/**
 Initialize an OCUnit formatter.
 @param dateProvider An object which returns the current date.
 @param suiteName The name of the suite. Since Inline doesn't provide a concept of suites (the whole thing is a suite...) but SenTestingKit does, it is necessary to write a dummy suite name in the report.
 @return An initialized OCUnit formatter.
 */
- (id)initWithDateProvider:(INLDateProvider *)dateProvider suiteName:(NSString *)suiteName;

@end
