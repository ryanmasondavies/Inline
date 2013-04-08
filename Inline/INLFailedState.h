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
 @param name The name for the failed state.
 @return An initialized failed state.
 */
- (id)initWithName:(NSString *)name;

@end
