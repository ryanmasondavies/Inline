//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** A reporter forwards messages to each of its writers. */
@interface INLReporter : NSObject <INLRunnerDelegate>

/**
 Initialize a reporter.
 @param writers The writers for the reporter to forward messages to.
 @return An initialized reporter.
 */
- (id)initWithWriters:(NSArray *)writers;

@end
