Pod::Spec.new do |s|
  s.name = 'Inline'
  s.version = '0.3.0'
  s.license = 'MIT'
  s.platform = :ios, '5.0'
  s.summary = "Simplifies testing frameworks which integrate with Xcode, allowing developers to test any way they want."
  s.homepage = 'https://github.com/rdavies/Inline'
  s.author = { 'Ryan Davies' => 'ryan@ryandavies.net' }
  s.source = { :git => 'https://github.com/rdavies/Inline.git', :tag => s.version.to_s }
  s.source_files = 'Inline/*.{h,m}'
  s.framework    = 'SenTestingKit'
  s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SDKROOT)/Developer/Library/Frameworks" "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }
  s.requires_arc = true
end
