//
//  INLTestWriter.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLReporter.h"

/** Writes out the name of each test as a runner proceeds through a hierarchy. */
@interface INLTestWriter : NSObject <INLReporter>

/**
 Initialize a test writer.
 @param output The output for the test writer.
 @return An initialized test writer.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
