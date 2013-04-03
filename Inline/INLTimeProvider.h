//
//  INLTimeProvider.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Provides the current time as an NSTimeInterval. */
@interface INLTimeProvider : NSObject

/** @return The current time in seconds since 1 Jan, 1970. */
- (NSTimeInterval)time;

@end
