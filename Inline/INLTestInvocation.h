//
//  INLTestInvocation.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTest;

@interface INLTestInvocation : NSInvocation
+ (instancetype)invocationWithTest:(INLTest *)test;
@property (strong, nonatomic) INLTest *test;
@end
