//
//  INLTest.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** A protocol by which test objects must conform. The interface defines only one method, -execute, which is used to execute the test. */
@protocol INLTest <NSObject>

/** Runs the test. */
- (void)execute;

@end
