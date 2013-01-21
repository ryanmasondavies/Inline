BUILD_DIR = File.join(Dir.pwd, 'build')

task :build_pods do
  system "xcodebuild -project Pods/Pods.xcodeproj -target \"Pods-Unit Tests\" -configuration Debug -sdk iphonesimulator6.0 SYMROOT=\"#{BUILD_DIR}\" clean build"
end

task :run_tests do
  system "xcodebuild -project Inline.xcodeproj -target \"Unit Tests\" -configuration Debug -sdk iphonesimulator6.0 SYMROOT=\"#{BUILD_DIR}\" clean build"
end
