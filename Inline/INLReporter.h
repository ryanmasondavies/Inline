//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** A reporter which formats tests by rendering their names and indenting them appropriately within groups. */
@interface INLReporter : NSObject <INLRunnerDelegate>

/**
 Initialize a reporter.
 @param output The output for the reporter.
 @return An initialized reporter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
