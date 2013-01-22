Given /^I have a test suite$/ do
  create_temporary_project
end

Given /^the test suite has invocations for the following tests:$/ do |table|
  write_test_for_temporary_project(objc_code_for_test_case("SomeTests", table.hashes))
end

When /^I run the tests$/ do
  step "I cd to \"Project\""
  build_commands.each {|command| step "I run `#{command}`"}
  step "I cd to \"..\""
end

Then /^the following tests should have passed:$/ do |table|
  table.hashes.each do |result|
    step "the output should contain \"Test Case '#{result["name"]}' passed\""
  end
end

Then /^the following tests should have failed:$/ do |table|
  table.hashes.each do |result|
    step "the output should contain \"Test Case '#{result["name"]}' failed\""
  end
end

Then /^there should have been no failures$/ do
  step "the output should match /Executed . tests, with 0 failures/"
end
