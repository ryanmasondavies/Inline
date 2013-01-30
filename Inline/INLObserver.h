//
//  INLObserver.h
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@protocol INLReporter;

@interface INLObserver : SenTestObserver

+ (id <INLReporter>)activeReporter;
+ (void)setActiveReporter:(id <INLReporter>)reporter;

@end
