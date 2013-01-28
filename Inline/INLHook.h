//
//  INLHook.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

/** Abstract superclass for hooks of varying scope. */
@interface INLHook : NSObject

/** The group which the hook has been added to. */
@property (weak, nonatomic) INLGroup *parent;

@end
