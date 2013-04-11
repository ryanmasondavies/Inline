//
//  INLRunner.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLRunner.h"
#import "INLComponent.h"
#import "INLResponder.h"

@implementation INLRunner

- (void)runComponent:(id<INLComponent>)component withResponder:(id<INLResponder>)responder
{
    [responder runDidStart];
    [component runWithResponder:responder];
    [responder runDidFinish];
}

@end
