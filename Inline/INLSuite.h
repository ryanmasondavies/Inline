//
//  INLSuite.h
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Each subclass returns components (tests, hooks, groups) in a root group. */
@interface INLSuite : NSObject

/**
 @return The root group in the suite's component hierarchy.
 */
- (INLGroup *)rootGroup;

@end
