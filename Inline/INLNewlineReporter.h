//
//  INLNewlineReporter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLReporter.h"

/** Creates a report that includes the newlines between tests and groups. */
@interface INLNewlineReporter : NSObject <INLReporter>

/**
 Initialize a newline reporter.
 @param output The output for the newline reporter.
 @return An initialized newline reporter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
