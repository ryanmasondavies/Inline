//
//  INLGroup.h
//  Inline
//
//  Created by Ryan Davies on 28/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLNode.h"
@class INLTest, INLHook;

/** Represents a group of tests and their hooks. */
@interface INLGroup : INLNode

/**
 Adds a group to groups.
 @param group The group to add as a child. */
- (void)addGroup:(INLGroup *)group;

/**
 Adds a test to tests.
 @param test The test to add to tests. */
- (void)addTest:(INLTest *)test;

/**
 Adds a hook to hooks.
 @param hook The hook to add to hooks. */
- (void)addHook:(INLHook *)hook;

/** A list of the child groups that have been added to the group. */
@property (strong, nonatomic) NSArray *groups;

/** A list of the tests that have been added to the group. */
@property (strong, nonatomic) NSArray *tests;

/** A list of the hooks that have been added to the group. */
@property (strong, nonatomic) NSArray *hooks;

@end
