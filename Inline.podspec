Pod::Spec.new do |s|
  s.name = 'Inline'
  s.version = '0.3.0'
  s.license = 'MIT'
  s.platform = :ios, '5.0'
  s.summary = "Extends SenTestCase to allow for easier implementation of alternative DSLs."
  s.homepage = 'https://github.com/rdavies/Inline'
  s.author = { 'Ryan Davies' => 'ryan@ryandavies.net' }
  s.source = { :git => 'https://github.com/rdavies/Inline.git', :tag => s.version.to_s }
  s.source_files = 'Inline/*.{h,m}'
  s.resources    = 'Inline/OCUnit.mustache'
  s.framework    = 'SenTestingKit'
  s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(SDKROOT)/Developer/Library/Frameworks" "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }
  s.requires_arc = true
  
  s.dependency "Caboodle", "~> 0.2.0"
  s.dependency 'InflectorKit', '~> 0.0.1'
  s.dependency 'TransformerKit', '~> 0.0.2'
  s.dependency 'GRMustache', '~> 6.4.0'
end
