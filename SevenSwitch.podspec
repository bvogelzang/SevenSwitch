Pod::Spec.new do |s|
  s.name             = "SevenSwitch"
  s.summary          = "iOS7 style drop in replacement for UISwitch."
  s.version          = "2.0.0"
  s.homepage         = "https://github.com/bvogelzang/SevenSwitch"
  s.license          = { :type => 'MIT', file: 'LICENSE'}
  s.author           = { "Ben Vogelzang" => "bvogelzang@breuer.com" }
  s.source           = {
    :git => "https://github.com/hyperoslo/SevenSwitch.git",
    :tag => s.version.to_s
  }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'SevenSwitch.swift'
  s.exclude_files = 'Classes/Exclude'
  s.frameworks = 'UIKit', 'QuartzCore'
# s.dependency 'AFNetworking', '~> 2.3'
end
