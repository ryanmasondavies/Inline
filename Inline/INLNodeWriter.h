//
//  INLNodeWriter.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** Writes out the name of each node as a runner proceeds through a hierarchy. */
@interface INLNodeWriter : NSObject <INLRunnerDelegate>

/**
 Initialize a node writer.
 @param output The output for the node writer.
 @return An initialized node writer.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
