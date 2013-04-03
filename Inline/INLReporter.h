//
//  INLReporter.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLVisitor.h"

@interface INLReporter : NSObject <INLVisitor>

- (id)initWithOutput:(NSMutableString *)output;

@end
