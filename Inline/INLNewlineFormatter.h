//
//  INLNewlineFormatter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLFormatter.h"

/** Inserts newlines after group and test names. */
@interface INLNewlineFormatter : NSObject <INLFormatter>

/**
 Initialize a newline formatter.
 @param output The output for the newline formatter.
 @return An initialized newline formatter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
