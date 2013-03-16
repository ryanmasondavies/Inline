Pod::Spec.new do |s|
  s.name = 'Inline'
  s.version = '0.2.1'
  s.license = 'MIT'
  s.platform = :ios, '5.0'
  s.summary = "Extends SenTestCase to allow for easier implementation of alternative DSLs."
  s.homepage = 'https://github.com/rdavies/Inline'
  s.author = { 'Ryan Davies' => 'ryan@ryandavies.net' }
  s.source = { :git => 'https://github.com/rdavies/Inline.git', :tag => s.version.to_s }
  s.source_files = 'Inline/*.{h,m}'
  s.framework    = 'SenTestingKit'
  s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SDKROOT)/Developer/Library/Frameworks" "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }
  s.requires_arc = true
end
