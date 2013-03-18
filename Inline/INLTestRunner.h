//
//  INLTestRunner.h
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLVisitor.h"

/** A test runner visits each element in a node tree and runs each. */
@interface INLTestRunner : NSObject <INLVisitor>

@end
