//
//  INLIterator.h
//  Inline
//
//  Created by Ryan Davies on 19/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Interface for iterator objects. */
@protocol INLIterator <NSObject>

/** @return The first item in the list. */
- (id)first;

/** @return The next item in the list. */
- (id)next;

@end
