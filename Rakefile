require 'rubygems'
require 'xcodebuild'

XcodeBuild::Tasks::BuildTask.new do |t|
  t.workspace = "Inline.xcworkspace"
  t.scheme = "Pods-Unit Tests"
  t.configuration = "Debug"
  t.sdk = "iphonesimulator6.0"
  t.formatter = XcodeBuild::Formatters::ProgressFormatter.new
end

XcodeBuild::Tasks::BuildTask.new do |t|
  t.project_name = "Inline.xcodeproj"
  t.target = "Unit Tests"
  t.configuration = "Debug"
  t.sdk = "iphonesimulator6.0"
end
