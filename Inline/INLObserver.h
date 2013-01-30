//
//  INLObserver.h
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@protocol INLReporter;

/** Acts as an adapter for reporters. */
@interface INLObserver : SenTestObserver

/** @return The currently active reporter which INLObserver delegates messages to. */
+ (id <INLReporter>)activeReporter;

/** @param reporter The active reporter to assign. */
+ (void)setActiveReporter:(id <INLReporter>)reporter;

@end
