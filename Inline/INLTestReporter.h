//
//  INLTestReporter.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLFormatter.h"

/** Creates a report containing the name of each test. */
@interface INLTestReporter : NSObject <INLFormatter>

/**
 Initialize a test reporter.
 @param output The output for the test reporter.
 @return An initialized test reporter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
