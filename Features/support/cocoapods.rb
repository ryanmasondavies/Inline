PODFILE_CONTENTS = <<-EOF
platform :ios
target 'Tests' do
  pod 'Inline', :local => '../../../'
end
EOF

def write_podfile(path)
  podfile = File.open(path, "w")
  podfile.write PODFILE_CONTENTS
  podfile.close
end
