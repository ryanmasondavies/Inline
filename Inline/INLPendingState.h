//
//  INLPendingState.h
//  Inline
//
//  Created by Ryan Davies on 02/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The pending state of a test. */
@interface INLPendingState : NSObject

/** Initialize a pending state.
 @param label The label for the pending state.
 @return An initialized pending state.
 */
- (id)initWithLabel:(NSString *)label;

@end
