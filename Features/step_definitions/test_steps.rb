Given /^I have a test suite$/ do
  # Copy the template project to the tmp directory:
  step "a directory named \"Project\""
  FileUtils.cp_r(Dir["#{features_path}/Fixtures/Project/*"], "#{@dirs[0]}/Project")
end

Given /^it has a test case with the content:$/ do |content|
  f = File.open(File.join(@dirs[0], 'Project', 'Tests', 'Tests.m'), "w")
  f.write content
  f.close
end

When /^I add Inline as a dependency using CocoaPods$/ do
  # Add a Podfile including Inline as a dependency:
  podfile = File.open(File.join(@dirs[0], 'Project', 'Podfile'), "w")
  podfile.write <<-EOF
platform :ios
target 'Tests' do
  pod 'Inline', :local => '../../../'
end
  EOF
  podfile.close
end

When /^I cd to the test suite directory$/ do
  step "I cd to \"Project\""
end

When /^I successfully run the tests$/ do
  step "I successfully run `xcodebuild -project Pods/Pods.xcodeproj -target Pods-Tests -configuration Debug -sdk iphonesimulator6.0 SYMROOT=#{build_path} clean build`"
  step "I successfully run `xcodebuild -project Project.xcodeproj -target Tests -configuration Debug -sdk iphonesimulator6.0 SYMROOT=#{build_path} clean build`"
end
