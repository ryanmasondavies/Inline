//
//  INLTestCase.h
//  Inline
//
//  Created by Ryan Davies on 18/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class INLTestInvocation;

@interface INLTestCase : SenTestCase

+ (void)addTestInvocation:(INLTestInvocation *)testInvocation;
+ (void)removeTestInvocation:(INLTestInvocation *)testInvocation;

@end
