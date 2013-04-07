//
//  INLTestIndenter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** Indents tests according to their position in the hierarchy. */
@interface INLTestIndenter : NSObject <INLRunnerDelegate>

/**
 Initialize a test indenter.
 @param output The output for the test indenter.
 @return An initialized test indenter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
