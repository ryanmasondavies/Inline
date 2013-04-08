//
//  INLGroupWriter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLReporter.h"

/** Creates a report containing the names of each group. */
@interface INLGroupReporter : NSObject <INLReporter>

/**
 Initialize a group reporter.
 @param output The output for the group reporter.
 @return An initialized test reporter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
