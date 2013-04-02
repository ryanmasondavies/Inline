Given /^I have added (.*) to my Podfile$/ do |library|
  write_podfile(File.join(temporary_project_path, 'Podfile'), [library])
end

Given /^I have successfully installed my pods$/ do
  step "I cd to \"Project\""
  step "I successfully run `pod install`"
  step "I cd to \"..\""
end
