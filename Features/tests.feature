Feature: Tests
  In order to write tests more easily
  As a developer
  I want to be able to create suites and add tests to them
  
  Background:
    Given I have a test suite
      And I have added Inline to my Podfile
      And I have successfully installed my pods
  
  Scenario: Passing Tests
    Given the test suite has the tests:
      """
      #import <Inline/Inline.h>
      @interface Tests : INLSuite; @end
      @implementation Tests
      
      - (void)addNodesToGroup:(INLGroup *)group
      {
          INLTest *catTest = [[INLTest alloc] initWithLabel:@"test my cat" block:^{}];
          INLTest *dogTest = [[INLTest alloc] initWithLabel:@"test my dog" block:^{}];
          [group addNode:catTest];
          [group addNode:dogTest];
      }
      
      @end
      """
     When I run my tests
     Then I should see the output:
       """
       ✓ test my cat
       ✓ test my dog
       """

  Scenario: Failing Tests
    Given the test suite has the tests:
      """
      #import <Inline/Inline.h>
      @interface Tests : INLSuite; @end
      @implementation Tests
      
      - (void)addNodesToGroup:(INLGroup *)group
      {
          INLTest *catTest = [[INLTest alloc] initWithLabel:@"test my cat" block:^{
              // fail somehow
          }];
  
          INLTest *dogTest = [[INLTest alloc] initWithLabel:@"test my dog" block:^{
              // fail somehow
          }];
          
          [group addNode:catTest];
          [group addNode:dogTest];
      }
      
      @end
      """
     When I run my tests
     Then I should see the output:
       """
       × test my cat
       × test my dog
       """
