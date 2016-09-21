Pod::Spec.new do |s|
  s.version      = "0.0.1"
  s.summary      = "A short description of DFITableViewManager."
  s.description  = <<-DESC
                   DESC

  s.homepage     = "http://EXAMPLE/DFITableViewManager"
  
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "sdaheng" => "shidaheng@gmail.com" }
  
  s.platform     = :ios, "8.0"

  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/sdaheng/DFITableViewManager.git", :tag => "0.0.1" }

  s.source_files  = "DFITableViewManager/**/*.{h,m}"

  s.public_header_files = ["DFITableViewManager/DFITableViewModel.h",
			   "DFITableViewManager/DFITableViewPaging.h",
			   "DFITableViewManager/DFITableViewConfiguration.h"] 

  s.requires_arc = true

end
