//
//  INLTextFormatter.m
//  Inline
//
//  Created by Ryan Davies on 09/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "INLTextFormatter.h"
#import "INLGroup.h"
#import "INLTest.h"

@implementation INLTextFormatter

- (void)writeRunDidStartToReport:(NSMutableString *)report
{
}

- (void)writeRunDidFinishToReport:(NSMutableString *)report
{
}

- (void)writeGroupDidStart:(INLGroup *)group toReport:(NSMutableString *)report
{
    [report appendString:[group name]];
}

- (void)writeGroupDidFinish:(INLGroup *)group toReport:(NSMutableString *)report
{
}

- (void)writeTestDidStart:(INLTest *)test toReport:(NSMutableString *)report
{
}

- (void)writeTestDidPass:(INLTest *)test withDuration:(NSTimeInterval)duration toReport:(NSMutableString *)report
{
    [report appendString:[test name]];
}

- (void)writeTestDidSkip:(INLTest *)test toReport:(NSMutableString *)report
{
    [report appendString:[test name]];
}

- (void)writeTestDidFail:(INLTest *)test withException:(NSException *)exception toReport:(NSMutableString *)report
{
    [report appendString:[test name]];
}

@end
