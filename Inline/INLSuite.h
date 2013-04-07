//
//  INLSuite.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Each subclass returns nodes (tests, hooks, groups) in a root group. */
@interface INLSuite : NSObject

/**
 @return The root group in the suite's node hierarchy.
 */
- (INLGroup *)rootGroup;

@end
