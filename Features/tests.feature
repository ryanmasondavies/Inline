Feature: Tests
  In order to write tests more easily
  As a developer
  I want to be able to create suites and add tests to them
  
  Background:
    Given I have a test suite
      And I have added Inline to my Podfile
      And I have successfully installed my pods
  
  Scenario: Passing Tests
    Given my test suite has the tests:
      """
      #import <Inline/Inline.h>
      @interface Tests : INLSuite; @end
      @implementation Tests
      - (void)addNodesToGroup:(INLGroup *)group
      {
          INLTestPassed *catPassed = [[INLTestPassed alloc] initWithLabel:@"[passed] test my cat"];
          INLTestReady *catReady = [[INLTestReady alloc] initWithLabel:@"test my cat" block:^{} passedState:catPassed failedState:nil];
          INLTest *catTest = [[INLTest alloc] initWithState:catReady weight:@0];
          [group addNode:catTest];
      }
      @end
      """
     When I run my tests
     Then the output should contain:
       """
       [passed] test my cat
       """

  Scenario: Failing Tests
    Given my test suite has the tests:
      """
      #import <Inline/Inline.h>
      @interface Tests : INLSuite; @end
      @implementation Tests
      - (void)addNodesToGroup:(INLGroup *)group
      {
          INLTestFailed *catFailed = [[INLTestFailed alloc] initWithLabel:@"[failed] test my cat" reason:@""];
          INLTestReady *catReady = [[INLTestReady alloc] initWithLabel:@"test my cat" block:^{
              [NSException raise:NSInternalInconsistencyException reason:@"cat fails"];
          } passedState:catFailed failedState:nil];
          INLTest *catTest = [[INLTest alloc] initWithState:catReady weight:@0];
          [group addNode:catTest];
      }
      @end
      """
     When I run my tests
     Then the output should contain:
       """
       [failed] test my cat (cat fails)
       """
