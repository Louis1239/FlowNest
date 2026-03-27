#
# Be sure to run `pod lib lint FlowNest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlowNest'
  s.version          = '0.1.0'
  s.summary          = 'Shared header container with horizontally paged child scroll views.'

  s.description      = <<-DESC
FlowNest provides a container controller for a shared header and multiple child
scroll views with coordinated nested scrolling behavior.
                       DESC

  s.homepage         = 'https://github.com/Louis1239/FlowNest'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Louis' => '13032678708@163.com' }
  s.source           = { :git => 'https://github.com/Louis1239/FlowNest.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'

  s.source_files = 'FlowNest/Classes/**/*.{swift}'
  s.dependency 'MJRefresh'
end
