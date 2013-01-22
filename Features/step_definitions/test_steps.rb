Given /^I have a test suite$/ do
  # Copy the template project to the tmp directory:
  step "a directory named \"Project\""
  FileUtils.cp_r(Dir["#{features_path}/Fixtures/Project/*"], "#{@dirs[0]}/Project")
end

Given /^the test suite has 3 passing tests$/ do
  f = File.open(File.join(@dirs[0], 'Project', 'Tests', 'Tests.m'), "w")
  f.write <<-EOF
  #import <SenTestingKit/SenTestingKit.h>
  #import <Inline/Inline.h>
  @interface SomeTests : INLTestCase; @end
  @implementation SomeTests
  + (void)initialize
  {
      [@[@"cat", @"dog", @"rabbit"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
          INLTest *test = [[INLTest alloc] init];
          [test setName:name];
          [test setBlock:^{}];
          [self addTestInvocation:[INLTestInvocation invocationWithTest:test]];
      }];
  }
  @end
  EOF
  
  f.close
end

Given /^the test suite has 2 passing tests and 1 failing test$/ do
  f = File.open(File.join(@dirs[0], 'Project', 'Tests', 'Tests.m'), "w")
  f.write <<-EOF
  #import <SenTestingKit/SenTestingKit.h>
  #import <Inline/Inline.h>
  @interface SomeTests : INLTestCase; @end
  @implementation SomeTests
  + (void)initialize
  {
      [@[@"cat", @"dog", @"rabbit"] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
          INLTest *test = [[INLTest alloc] init];
          [test setName:name];
          if (idx == 0) {
              [test setBlock:^{
                  [[NSException exceptionWithName:SenTestFailureException reason:@"Failed!" userInfo:@{SenTestFilenameKey: @(__FILE__), SenTestLineNumberKey: @(__LINE__)}] raise];
              }];
          } else {
              [test setBlock:^{}];
          }
          [self addTestInvocation:[INLTestInvocation invocationWithTest:test]];
      }];
  } 
  @end
  EOF
  f.close
end

Given /^I have added Inline as a dependency using CocoaPods$/ do
  podfile = File.open(File.join(@dirs[0], 'Project', 'Podfile'), "w")
  podfile.write <<-EOF
platform :ios
target 'Tests' do
  pod 'Inline', :local => '../../../'
end
  EOF
  podfile.close
end

Given /^I have successfully installed the pods$/ do
  step "I cd to \"Project\""
  step "I successfully run `pod install`"
  step "I cd to \"..\""
end

When /^I run the tests$/ do
  step "I cd to \"Project\""
  
  builds = [
    { "project" => "Pods/Pods.xcodeproj", "target" => "Pods-Tests" },
    { "project" => "Project.xcodeproj",   "target" => "Tests" }
  ]
  
  builds.each do |build|
    step "I run `xcodebuild -project #{build["project"]} -target #{build["target"]} -configuration Debug -sdk iphonesimulator6.0 SYMROOT=#{build_path} clean build`"
  end
  
  step "I cd to \"..\""
end
