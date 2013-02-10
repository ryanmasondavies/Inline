//
//  INLNode.m
//  Inline
//
//  Created by Ryan Davies on 10/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
#import "INLGroup.h"
#import "INLNodePath.h"

@implementation INLNode

- (INLNodePath *)nodePath
{
    return [[INLNodePath alloc] initWithDestinationNode:self];
}

@end
