//
//  INLTestFactory.h
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTest;

@interface INLTestFactory : NSObject

+ (INLTest *)createTestLabelled:(NSString *)label withParents:(NSArray *)parents;

@end
