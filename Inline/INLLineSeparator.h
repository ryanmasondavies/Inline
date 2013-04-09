//
//  INLLineSeparator.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLFormatter.h"

/** Inserts newlines after group and test names. */
@interface INLLineSeparator : NSObject <INLFormatter>

/**
 Initialize a line separator.
 @param output The output for the line separator.
 @return An initialized line separator.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
