//
//  INLDateProvider.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Provides dates by composition. Primarily necessary for testing. */
@interface INLDateProvider : NSObject

/** @return The current date. */
- (NSDate *)currentDate;

@end
