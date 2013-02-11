//
//  INLTestFactory.m
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTestFactory.h"

@implementation INLTestFactory

+ (INLTest *)createTestLabelled:(NSString *)label withParents:(NSArray *)parents
{
    INLTest *test = [[INLTest alloc] init];
    [test setLabel:label];
    
    id current = test;
    for (id group in [parents reverseObjectEnumerator]) {
        [current setParent:group];
        current = group;
    }
    
    return test;
}

@end
