#
# Be sure to run `pod lib lint XpdButtons.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'XpdButtons'
s.version          = '0.1.0'
s.summary          = 'A UIView which provide multiple buttons arranged in pageViewController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'A UIView which provide multiple buttons arranged in pageViewController. Button layout depends on total number of buttons you want. It will club 4 buttons in one page other buttons will be in next page (which will comeup after horizontal scroll) Buttons will looks like
..[####] [####]
[######] [#######]. PS :- Check screenshot on home page'

s.homepage         = 'https://github.com/xpd54/XpdButtons'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Ravi Prakash' => 'raviprakash.xpd54@gmail.com' }
s.source           = { :git => 'https://github.com/xpd54/XpdButtons.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'XpdButtons/Classes/**/*'

# s.resource_bundles = {
#   'XpdButtons' => ['XpdButtons/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
