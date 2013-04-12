//
//  INLComponent.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLCompilable.h"

/** The interface for groups, tests, and hooks to conform to. */
@protocol INLComponent <NSObject, INLCompilable>

/** @return A numerical value used for ordering components within a component graph. */
- (NSNumber *)weight;

@end
