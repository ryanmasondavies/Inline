//
//  INLOCUnitReporterFormatTests.m
//  Integrated Tests
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import <GRMustache/GRMustache.h>
#import <InflectorKit/NSString+InflectorKit.h>
#import <TransformerKit/TransformerKit.h>

@interface INLOCUnitReporterFormatTests : SenTestCase
@property (strong, nonatomic) GRMustacheTemplate *template;
@property (strong, nonatomic) NSMutableDictionary *results;
@end

@implementation INLOCUnitReporterFormatTests

- (void)setUp
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    self.template = [GRMustacheTemplate templateFromResource:@"OCUnit" bundle:bundle error:NULL];
    self.results = [@{
        @"threeDecimalPoints": [self createThreeDecimalNumberFormatter],
        @"pluralize": [GRMustacheFilter filterWithBlock:^id(NSNumber *count) {
            return [GRMustache renderingObjectWithBlock:^NSString *(GRMustacheTag *tag, GRMustacheContext *context, BOOL *HTMLSafe, NSError *__autoreleasing *error) {
                NSString *word = [tag renderContentWithContext:context HTMLSafe:HTMLSafe error:error];
                return [count isEqualToNumber:@1] ? word : [word pluralizedString];
            }];
        }],
        @"llamaCase": [NSValueTransformer valueTransformerForName:TKLlamaCaseStringTransformerName],
        @"numberOfFailures": [GRMustacheFilter filterWithBlock:^id(NSArray *tests) {
            __block NSUInteger failures = 0;
            [tests enumerateObjectsUsingBlock:^(NSDictionary *test, NSUInteger idx, BOOL *stop) {
                if (test[@"failure"]) {
                    failures ++;
                }
            }];
            return @(failures);
        }]
    } mutableCopy];
}

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
    // when
    [[self results] addEntriesFromDictionary:@{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.3,
        @"tests": @[]
    }];
    NSString *report = [[self template] renderObject:[self results] error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 0 tests, with 0 failures (0 unexpected) in 0.300 (0.300) seconds";
    STAssertEqualObjects(report, expected, nil);
}

- (void)testTemplateRendersSuiteWithOnePassingTest
{
    // when
    [[self results] addEntriesFromDictionary:@{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.5,
        @"tests": @[
            @{@"name": @"the great sample test", @"duration": @0.5}
        ]
    }];
    NSString *report = [[self template] renderObject:[self results] error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Case '-[Test theGreatSampleTest]' started.\n"
                         @"Test Case '-[Test theGreatSampleTest]' passed (0.500 seconds).\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 1 test, with 0 failures (0 unexpected) in 0.500 (0.500) seconds";
    STAssertEqualObjects(report, expected, nil);
}

- (void)testTemplateRendersSuiteWithTwoPassingTests
{
    // when
    [[self results] addEntriesFromDictionary:@{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @1.5,
        @"tests": @[
            @{@"name": @"the great sample test", @"duration": @0.5},
            @{@"name": @"the other great sample test", @"duration": @1.0}
        ]
    }];
    NSString *report = [[self template] renderObject:[self results] error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Case '-[Test theGreatSampleTest]' started.\n"
                         @"Test Case '-[Test theGreatSampleTest]' passed (0.500 seconds).\n"
                         @"Test Case '-[Test theOtherGreatSampleTest]' started.\n"
                         @"Test Case '-[Test theOtherGreatSampleTest]' passed (1.000 seconds).\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 2 tests, with 0 failures (0 unexpected) in 1.500 (1.500) seconds";
    STAssertEqualObjects(report, expected, nil);
}

- (void)testTemplateRendersSuiteWithOneFailingTest
{
    // when
    [[self results] addEntriesFromDictionary:@{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.001,
        @"tests": @[
            @{@"name": @"the great sample test", @"failure": @{@"filePath": @"SomeFile.m", @"lineNumber": @10, @"reason": @"Failed for some reason"}}
        ]
    }];
    NSString *report = [[self template] renderObject:[self results] error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Case '-[Test theGreatSampleTest]' started.\n"
                         @"SomeFile.m:10: error: -[Test theGreatSampleTest] : Failed for some reason\n"
                         @"Test Case '-[Test theGreatSampleTest]' failed (0.001 seconds).\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 1 test, with 1 failure (0 unexpected) in 0.001 (0.001) seconds";
    STAssertEqualObjects(report, expected, nil);
}

- (void)testTemplateRendersSuiteWithTwoFailingTests
{
    // when
    [[self results] addEntriesFromDictionary:@{
        @"startDate": [NSDate dateWithTimeIntervalSince1970:0],
        @"finishDate": [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24],
        @"duration": @0.005,
        @"tests": @[
            @{@"name": @"the great sample test", @"failure": @{@"filePath": @"SomeFile.m", @"lineNumber": @10, @"reason": @"Failed for some reason"}},
            @{@"name": @"the other great sample test", @"failure": @{@"filePath": @"SomeOtherFile.m", @"lineNumber": @20, @"reason": @"Failed for some other reason"}}
        ]
    }];
    NSString *report = [[self template] renderObject:[self results] error:NULL];
    
    // then
    NSString *expected = @"Test Suite 'Suite' started at 1970-01-01 00:00:00 +0000\n"
                         @"Test Case '-[Test theGreatSampleTest]' started.\n"
                         @"SomeFile.m:10: error: -[Test theGreatSampleTest] : Failed for some reason\n"
                         @"Test Case '-[Test theGreatSampleTest]' failed (0.001 seconds).\n"
                         @"Test Case '-[Test theOtherGreatSampleTest]' started.\n"
                         @"SomeOtherFile.m:20: error: -[Test theOtherGreatSampleTest] : Failed for some other reason\n"
                         @"Test Case '-[Test theOtherGreatSampleTest]' failed (0.001 seconds).\n"
                         @"Test Suite 'Suite' finished at 1970-01-02 00:00:00 +0000.\n"
                         @"Executed 2 tests, with 2 failures (0 unexpected) in 0.005 (0.005) seconds";
    STAssertEqualObjects(report, expected, nil);
}

@end
