//
//  INLNode.h
//  Inline
//
//  Created by Ryan Davies on 08/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol INLVisitor;

/** The interface for groups, tests, and hooks to conform to. */
@protocol INLNode <NSObject>

/** Used for ordering nodes within a node graph. */
- (NSNumber *)weight;

/** Used to trigger methods for visitors, allowing them to easily traverse the structure. */
- (void)acceptVisitor:(id <INLVisitor>)visitor;

@end
