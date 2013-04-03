//
//  INLReporterTests.m
//  Inline
//
//  Created by Ryan Davies on 03/04/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

/* Necessary because OCMock does not support stubbing -description. */
@interface INLDescribableNode : NSObject

- (id)initWithDescription:(NSString *)description;

@end

@interface INLDescribableNode ()
@property (copy, nonatomic) NSString *description;
@end

@implementation INLDescribableNode

- (id)initWithDescription:(NSString *)description
{
    if (self = [self init]) {
        [self setDescription:description];
    }
    return self;
}

@end

@interface INLReporterTests : SenTestCase

@end

@implementation INLReporterTests

- (void)testWhenNotNestedDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id test = [[INLDescribableNode alloc] initWithDescription:@"test"];
    
    // when
    [reporter visitTest:test];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedInBlankGroupDoesNotIndentTest
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [[INLDescribableNode alloc] initWithDescription:@""];
    id test = [[INLDescribableNode alloc] initWithDescription:@"test"];
    
    // when
    [reporter enterGroup:group];
    [reporter visitTest:test];
    
    // then
    [[output should] beEqualTo:@"test\n"];
}

- (void)testWhenNestedOnceIndentsTestOnce
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [[INLDescribableNode alloc] initWithDescription:@"group"];
    id test = [[INLDescribableNode alloc] initWithDescription:@"test"];
    
    // when
    [reporter enterGroup:group];
    [reporter visitTest:test];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\n"];
}

- (void)testWhenNestedTwiceIndentsTestTwice
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) groups[i] = [[INLDescribableNode alloc] initWithDescription:@"group"];
    id test = [[INLDescribableNode alloc] initWithDescription:@"test"];
    
    // when
    [reporter enterGroup:groups[0]];
    [reporter enterGroup:groups[1]];
    [reporter visitTest:test];
    
    // then
    [[output should] beEqualTo:@"group\n\tgroup\n\t\ttest\n"];
}

- (void)testWhenUnnestedGroupComesAfterNestedTestDoesNotIndent
{
    // given
    NSMutableString *output = [[NSMutableString alloc] init];
    INLReporter *reporter = [[INLReporter alloc] initWithOutput:output];
    id group = [[INLDescribableNode alloc] initWithDescription:@"group"];
    NSMutableArray *tests = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i ++) tests[i] = [[INLDescribableNode alloc] initWithDescription:@"test"];
    
    // when
    [reporter enterGroup:group];
    [reporter visitTest:tests[0]];
    [reporter leaveGroup:group];
    [reporter enterGroup:tests[1]];
    
    // then
    [[output should] beEqualTo:@"group\n\ttest\ntest\n"];
}

@end
