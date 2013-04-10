//
//  INLOCUnitReporterFormatTests.m
//  Integrated Tests
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <GRMustache/GRMustache.h>
#import <TransformerKit/TransformerKit.h>

@interface INLOCUnitReporterFormatTests : SenTestCase

@end

@implementation INLOCUnitReporterFormatTests

- (NSNumberFormatter *)createThreeDecimalNumberFormatter
{
    // when
    NSNumberFormatter *threeDecimalPoints = [[NSNumberFormatter alloc] init];
    [threeDecimalPoints setNumberStyle:NSNumberFormatterDecimalStyle];
    [threeDecimalPoints setMinimumFractionDigits:3];
    [threeDecimalPoints setMaximumFractionDigits:3];
    return threeDecimalPoints;
}

- (void)testTemplateRendersEmptySuite
{
    // given
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    GRMustacheTemplate *template = [GRMustacheTemplate templateFromResource:@"OCUnit" bundle:bundle error:NULL];
    NSDictionary *results = @{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.3,
        @"tests": @[],
        @"threeDecimalPoints": [self createThreeDecimalNumberFormatter]
    };
    NSString *report = [template renderObject:results error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 0 tests, with 0 failures (0 unexpected) in 0.300 (0.300) seconds";
    STAssertEqualObjects(report, expected, nil);
}

- (void)testTemplateRendersSuiteWithOnePassingTest
{
    // given
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    GRMustacheTemplate *template = [GRMustacheTemplate templateFromResource:@"OCUnit" bundle:bundle error:NULL];
    
    // when
    NSDictionary *results = @{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.5,
        @"tests": @[
            @{@"name": @"the great sample test", @"duration": @0.5}
        ],
        @"threeDecimalPoints": [self createThreeDecimalNumberFormatter],
        @"llamaCase": [NSValueTransformer valueTransformerForName:TKLlamaCaseStringTransformerName]
    };
    NSString *report = [template renderObject:results error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Case '-[Test theGreatSampleTest]' started.\n"
                         @"Test Case '-[Test theGreatSampleTest]' passed (0.500 seconds).\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 1 test, with 0 failures (0 unexpected) in 0.500 (0.500) seconds";
    STAssertEqualObjects(report, expected, nil);
}

@end
