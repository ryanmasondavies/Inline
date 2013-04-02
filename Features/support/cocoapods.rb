def write_podfile(path, dependencies)
  content = ""
  dependencies.each do |dependency|
    if dependency.eql? "Inline"
      content << "pod \"#{dependency}\", :local => \"../../../\"\n"
    else
      content << "pod \"#{dependency}\"\n"
    end
  end
  
  podfile = File.open(path, "w")
  podfile.write <<-EOF
  platform :ios, '5.0'
  target 'Tests' do
    #{content}
  end
  EOF
  podfile.close
end
