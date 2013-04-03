//
//  INLRunner.h
//  Inline
//
//  Created by Ryan Davies on 18/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLVisitor.h"
@protocol INLRunnerDelegate;

/** A node runner visits each element in a node tree and runs each. */
@interface INLRunner : NSObject <INLVisitor>

/**
 Initialize a runner.
 @param delegate The object to be informed of progress.
 @return An initialized runner.
 */
- (id)initWithDelegate:(id<INLRunnerDelegate>)delegate;

@end
