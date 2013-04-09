//
//  INLPublisher.h
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Publishes a report e.g to the system log, to a file, or over the internet. */
@protocol INLPublisher <NSObject>

/**
 Publish a report.
 @param report The report to publish.
 */
- (void)publishReport:(NSMutableString *)report;

@end
