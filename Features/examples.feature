Feature: Tests
  As a developer,
  I want to more easily integrate with OCUnit,
  In order to run OCUnit tests with a different DSL.
  
  Scenario: Passing Tests
    Given I have a test suite
      And it has a test case with the content:
      """
      #import <SenTestingKit/SenTestingKit.h>
      #import <Inline/Inline.h>
      
      @interface SomeTests : INLTestCase; @end
      
      @implementation SomeTests
      
      + (void)initialize
      {
          [@[@"hello world", @"cat", @"dog"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
              INLTest *test = [[INLTest alloc] init];
              [test setName:name];
              [test setBlock:^{}];
              [self addTestInvocation:[INLTestInvocation invocationWithTest:test]];
          }];
      }
      
      @end
      """
    When I add Inline as a dependency using CocoaPods
     And I cd to the test suite directory
     And I successfully run `pod install`
     And I successfully run the tests
    Then the output should match:
      """
      Run test suite SomeTests
      Test Suite 'SomeTests' started at .*
      Run test case hello world
      Test Case 'hello world' started\.
      Test Case 'hello world' passed \(.* seconds\)\.
      
      Run test case cat
      Test Case 'cat' started\.
      Test Case 'cat' passed \(.* seconds\)\.
      
      Run test case dog
      Test Case 'dog' started\.
      Test Case 'dog' passed \(.* seconds\)\.
    
      Test Suite 'SomeTests' finished at .*\.
      Executed 3 tests, with 0 failures \(0 unexpected\) in .* seconds
      """
