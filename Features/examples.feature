Feature: Tests
  In order to run OCUnit tests with a different DSL
  As a developer
  I want to more easily integrate with OCUnit
  
  Background:
  Given I have a test suite
    And I have added Inline as a dependency using CocoaPods
    And I have successfully installed the pods
  
  Scenario: Passing Tests
    Given the test suite has 3 passing tests
     When I run the tests
     Then the output should match:
      """
      Run test suite SomeTests
      Test Suite 'SomeTests' started at .*
      Run test case cat
      Test Case 'cat' started\.
      Test Case 'cat' passed \(.* seconds\)\.
      
      Run test case dog
      Test Case 'dog' started\.
      Test Case 'dog' passed \(.* seconds\)\.
      
      Run test case rabbit
      Test Case 'rabbit' started\.
      Test Case 'rabbit' passed \(.* seconds\)\.
    
      Test Suite 'SomeTests' finished at .*\.
      Executed 3 tests, with 0 failures \(0 unexpected\) in .* seconds
      """
      
  @announce
  Scenario: Failing Test
    Given the test suite has 2 passing tests and 1 failing test
     When I run the tests
     Then the output should match:
      """
      Run test suite SomeTests
      Test Suite 'SomeTests' started at .*
      Run test case cat
      Test Case 'cat' started\.
      .*/Tests\.m:12: error: cat : Failed!
      Test Case 'cat' failed \(0\.000 seconds\)\.
      
      Run test case dog
      Test Case 'dog' started\.
      Test Case 'dog' passed \(0\.000 seconds\)\.
      
      Run test case rabbit
      Test Case 'rabbit' started\.
      Test Case 'rabbit' passed \(0\.000 seconds\)\.
      
      Test Suite 'SomeTests' finished at .*
      Executed 3 tests, with 1 failure \(0 unexpected\) in .* seconds
      """
