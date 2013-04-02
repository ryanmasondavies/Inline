Given /^I have a test suite$/ do
  create_temporary_project
end

Given /^my test suite has the tests:$/ do |content|
  write_spec_for_temporary_project(content)
end

When /^I run my tests$/ do
  step "I cd to \"Project\""
  build_commands.each {|command| step "I run `#{command}`"}
  step "I cd to \"..\""
end
