Feature: Tests
  In order to run OCUnit tests with a different DSL
  As a developer
  I want to more easily integrate with OCUnit
  
  Background:
  Given I have a test suite
    And I have added Inline as a dependency using CocoaPods
    And I have successfully installed the pods
  
  Scenario: All Tests Passing
    Given the test suite has the following tests:
      | name   | pass |
      | cat    | 1    |
      | dog    | 1    |
      | rabbit | 1    |
     When I run the tests
     Then the following tests should have passed:
      | name   |
      | cat    |
      | dog    |
      | rabbit |
      And there should have been no failures
      
  Scenario: One Test Failing
    Given the test suite has the following tests:
        | name   | pass |
        | cat    | 0    |
        | dog    | 1    |
        | rabbit | 1    |
     When I run the tests
     Then the following tests should have passed:
        | name   |
        | dog    |
        | rabbit |
      But the following tests should have failed:
        | name |
        | cat  |
        
  Scenario: All Tests Failing
    Given the test suite has the following tests:
        | name   | pass |
        | cat    | 0    |
        | dog    | 0    |
        | rabbit | 0    |
     When I run the tests
     Then the following tests should have failed:
        | name   |
        | cat    |
        | dog    |
        | rabbit |
