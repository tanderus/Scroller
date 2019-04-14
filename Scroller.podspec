#
# Be sure to run `pod lib lint Scroller.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Scroller'
  s.version          = '0.1.0'
  s.summary          = 'A scroller-like control for iOS'

  s.homepage         = 'https://github.com/tanderus/Scroller'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tanderus' => '6lackk@gmail.com' }
  s.source           = { :git => 'https://github.com/tanderus/Scroller.git', :tag => s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'
  s.source_files = 'Scroller/**/*'
  s.frameworks = 'UIKit'
end
