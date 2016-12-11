Pod::Spec.new do |s|
  s.name         = "SevenSwitch"
  s.version      = "2.0.0"
  s.summary      = "iOS7 style drop in replacement for UISwitch."
  s.homepage     = "https://github.com/bvogelzang/SevenSwitch"
  s.screenshots  = "https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.gif", "https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ben Vogelzang" => "bvogelzang@breuer.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/bvogelzang/SevenSwitch.git", :tag => "2.0.0" }
  s.source_files  = "SevenSwitch.swift"
  s.exclude_files = "Classes/Exclude"
  s.frameworks = "UIKit", "QuartzCore"
  s.requires_arc = true
end
