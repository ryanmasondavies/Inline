//
//  INLReportGroupIndenter.h
//  Inline
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLRunnerDelegate.h"

/** Indents groups according to their position in the hierarchy. */
@interface INLReportGroupIndenter : NSObject <INLRunnerDelegate>

/**
 Initialize a group indenter.
 @param output The output for the group indenter.
 @return An initialized group indenter.
 */
- (id)initWithOutput:(NSMutableString *)output;

@end

