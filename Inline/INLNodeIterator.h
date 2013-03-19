//
//  INLNodeIterator.h
//  Inline
//
//  Created by Ryan Davies on 19/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLIterator.h"

/** Enumerates through nodes after ordering them by weight. */
@interface INLNodeIterator : NSObject <INLIterator>

/** Initializes an iterator.
 @param nodes The nodes to be iterated through.
 @return A new iterator. */
- (id)initWithNodes:(NSMutableArray *)nodes;

@end
