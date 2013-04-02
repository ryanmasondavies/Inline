//
//  INLVisitor.h
//  Inline
//
//  Created by Ryan Davies on 17/03/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLGroup, INLTest, INLHook;

/** The interface for all objects that traverse the hierarchy. See the Visitor design pattern. */
@protocol INLVisitor <NSObject>

/** Visit a group. Invoked by [INLGroup acceptVisitor:]. */
- (void)visitGroup:(INLGroup *)group;

/** Visit a test. Invoked by [INLTest acceptVisitor:]. */
- (void)visitTest:(INLTest *)test;

/** Visit a hook. Invoked by [INLHook acceptVisitor:]. */
- (void)visitHook:(INLHook *)hook;

/** Leave a group. Invoked by [INLGroup acceptVisitor:]. */
- (void)leaveGroup:(INLGroup *)group;

@end
