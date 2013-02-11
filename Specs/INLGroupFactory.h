//
//  INLGroupFactory.h
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup;

@interface INLGroupFactory : NSObject

+ (INLGroup *)createGroupLabelled:(NSString *)label;

@end
