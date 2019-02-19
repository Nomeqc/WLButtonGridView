#
# Be sure to run `pod lib lint WLButtonGridView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WLButtonGridView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WLButtonGridView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Nomeqc/WLButtonGridView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nomeqc' => 'xie5405@163.com' }
  s.source           = { :git => 'https://github.com/Nomeqc/WLButtonGridView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'WLButtonGridView/Classes/**/*'
  s.public_header_files = 'WLButtonGridView/Classes/**/*.h'
  s.dependency 'YYCategories'
  s.dependency 'SDWebImage', '~> 4.0'
  
end
