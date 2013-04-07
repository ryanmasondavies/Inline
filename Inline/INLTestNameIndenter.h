//
//  INLTestNameIndenter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** Indents test names according to their position in the hierarchy. */
@interface INLTestNameIndenter : NSObject <INLRunnerDelegate>

/**
 Initialize a test name indenter.
 @param output The output for the test name indenter.
 @return An initialized test name indenter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
