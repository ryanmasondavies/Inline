Given /^I have a test suite$/ do
  create_temporary_project
end

Given /^the test suite has the test:$/ do |content|
  write_spec_for_temporary_project(content)
end

When /^I run the tests$/ do
  step "I cd to \"Project\""
  build_commands.each {|command| step "I run `#{command}`"}
  step "I cd to \"..\""
end
