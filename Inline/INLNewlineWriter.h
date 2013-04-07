//
//  INLNewlineWriter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

@interface INLNewlineWriter : NSObject <INLRunnerDelegate>

/**
 Initialize a newline writer.
 @param output The output for the newline writer.
 @return An initialized newline writer.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end
