//
//  INLGroupFormatter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLFormatter.h"

/** Adds group names to a report. */
@interface INLGroupFormatter : NSObject <INLFormatter>

/**
 Initialize a group formatter.
 @param output The output for the group formatter.
 @return An initialized test formatter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
