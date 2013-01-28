//
//  INLBuilder.h
//  Inline
//
//  Created by Ryan Davies on 24/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Defines an implementation for builder objects. It only specifies that the builder returns tests, but not the methods by which they are added as these can be specific to the language of the domain. It is called a 'builder' and not a collection or set because of its nature: it is responsible for _building_ objects based on a DSL. The format in which the DSL creates tests is unlikely to be linear or similar to any other, and so no default implementation can be provided. */
@protocol INLBuilder <NSObject>

/** @return The tests which have been added to the builder. */
- (NSArray *)tests;

@end
