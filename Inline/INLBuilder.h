//
//  INLBuilder.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** A builder specifies that the builder returns a root group which contains tests, but not the methods by which they are added as these are specific to the language of the domain. It is called a 'builder' and not a collection or set because of its nature: it is responsible for _building_ objects based on a DSL. */
@interface INLBuilder : NSObject

/** The group at the bottom of the builder's stack, to which all other groups, tests, and hooks must be added. */
@property (strong, nonatomic) INLGroup *rootGroup;

@end
