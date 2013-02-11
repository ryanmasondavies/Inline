//
//  INLNotificationFactory.h
//  Inline
//
//  Created by Ryan Davies on 11/02/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class INLTest;

@interface INLNotificationFactory : NSObject

+ (NSNotification *)createNotificationNamed:(NSString *)notificationName forSuiteNamed:(NSString *)suiteName;
+ (NSNotification *)createNotificationNamed:(NSString *)notificationName forTest:(INLTest *)test;
+ (NSNotification *)createNotificationNamed:(NSString *)notificationName forTest:(INLTest *)test thatFailsWithException:(NSException *)exception;

@end
