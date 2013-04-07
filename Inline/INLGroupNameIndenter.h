//
//  INLGroupNameIndenter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** Indents group names according to their position in the hierarchy. */
@interface INLGroupNameIndenter : NSObject <INLRunnerDelegate>

/**
 Initialize a group name indenter.
 @param output The output for the group name indenter.
 @return An initialized group name indenter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end

