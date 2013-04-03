//
//  INLTestState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTest;

/** A state in which a test can be in: pending, ready, passed, failed. */
@protocol INLTestState <NSObject>

/** Run the test. Applicable only to the ready state. */
- (void)runForTest:(INLTest *)test;

/** Describe the state of the test. */
- (NSString *)description;

@end
