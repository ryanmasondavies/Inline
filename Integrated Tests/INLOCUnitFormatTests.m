//
//  INLOCUnitReporterFormatTests.m
//  Integrated Tests
//
//  Created by Ryan Davies on 07/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

@interface INLOCUnitReporterFormatTests : SenTestCase

@end

@implementation INLOCUnitReporterFormatTests

- (void)testReporterOutputsPassingTestsInOCUnitFormat
{
    // given
    void(^passingTest)(NSString *) = ^(NSString *name, NSNumber *weight) {
        id<INLTestState> passed = [[INLPassedState alloc] initWithName:name];
        return [[INLTest alloc] initWithState:passed weight:weight];
    };
    void(^groupWithComponents)(NSString *, NSNumber *, NSArray *) = ^(NSString *name, NSNumber *weight, NSArray *components) {
        NSArray *sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES]];
        CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:[components mutableCopy] sortDescriptors:sortDescriptors];
        INLGroup *group = [[INLGroup alloc] initWithName:@"Group A" components:sorted weight:weight];
    };
    
    id<INLComponent> subgroup = groupWithComponents(@"Group B", @3, @[passingTest(@"Test C", @1), passingTest(@"Test D", @2)]);
    id<INLComponent> topGroup = groupWithComponents(@"Group A", @1, @[passingTest(@"Test A", @1), passingTest(@"Test B", @2), subgroup]);
    
    NSMutableString *output = [[NSMutableString alloc] init];
    id<INLRunnerDelegate> reporter = [[INLReportReporter alloc] initWithOutput:output];
//    reporter = [[INLOCFormatter alloc] initWithOutput:output];
//    reporter = [[INLOCStatistician alloc] initWithOutput:output];
//    reporter = [[INLExpander alloc] initWithOutput:output];
//    reporter = [[INLSeparator alloc] initWithOutput:output];
    
    INLRunner *runner = [[INLRunner alloc] initWithDelegate:reporter];
    
    // when
    [runner runByStartingAtComponent:topGroup];
    
    // then
    NSString *expected = @"";
    STAssertEqualObjects(output, expected, @"Output did not match expected value.");
}

@end
