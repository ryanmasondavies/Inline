//
//  INLFailedState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLTestState.h"

@interface INLFailedState : NSObject <INLTestState>

/**
 Initialize a failed state.
 @param label The label for the failed state.
 @param reason The reason for the failure.
 @return An initialized failed state.
 */
- (id)initWithLabel:(NSString *)label reason:(NSString *)reason;

@end
