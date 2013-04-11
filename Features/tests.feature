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
      - (INLGroup *)rootGroup
      {
          INLTimeProvider *timeProvider = [[INLTimeProvider alloc] init];
          INLStopwatch *stopwatch = [[INLStopwatch alloc] initWithTimeProvider:timeProvider];
          
          INLPassedState *catPassed = [[INLPassedState alloc] initWithName:@"test my cat"];
          INLReadyState *catReady = [[INLReadyState alloc] initWithName:@"test my cat" block:^{} stopwatch:stopwatch passedState:catPassed failedState:nil];
          INLTest *catTest = [[INLTest alloc] initWithState:catReady weight:@0];
          
          NSMutableArray *tests = [@[catTest] mutableCopy];
          NSSortDescriptor *lightestToHeaviest = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES];
          CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:tests sortDescriptors:@[lightestToHeaviest]];
          return [[INLGroup alloc] initWithName:@"" components:sorted weight:@0];
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
      - (INLGroup *)rootGroup
      {
          INLTimeProvider *timeProvider = [[INLTimeProvider alloc] init];
          INLStopwatch *stopwatch = [[INLStopwatch alloc] initWithTimeProvider:timeProvider];
          
          INLFailedState *dogFailed = [[INLFailedState alloc] initWithName:@"test my dog"];
          INLReadyState *dogReady = [[INLReadyState alloc] initWithName:@"test my dog" block:^{
              [NSException raise:NSInternalInconsistencyException format:@"dog failed"];
          } stopwatch:stopwatch passedState:nil failedState:dogFailed];
          INLTest *dogTest = [[INLTest alloc] initWithState:dogReady weight:@1];
    
          NSMutableArray *tests = [@[dogTest] mutableCopy];
          NSSortDescriptor *lightestToHeaviest = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:YES];
          CBDSortedArray *sorted = [[CBDSortedArray alloc] initWithObjects:tests sortDescriptors:@[lightestToHeaviest]];
          return [[INLGroup alloc] initWithName:@"" components:sorted weight:@0];
      }
      @end
      """
     When I run my tests
     Then the output should contain:
       """
       [failed] test my cat (cat fails)
       """
