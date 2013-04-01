Given /^I have added (.*) as a dependency using CocoaPods$/ do |library|
  write_podfile(File.join(temporary_project_path, 'Podfile'), ["library"])
end

Given /^I have successfully installed the pods$/ do
  step "I cd to \"Project\""
  step "I successfully run `pod install`"
  step "I cd to \"..\""
end
