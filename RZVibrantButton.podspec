#
# Be sure to run `pod lib lint RZVibrantButton.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RZVibrantButton"
  s.version          = "0.1.0"
  s.summary          = "A stylish button that embodies iOS 8's Vibrancy Effects. Built in Swift."
  s.description      = <<-DESC
                       RZVibrantButton is a stylish button with iOS 8 vibrancy effect built using Swift. It is a subclass of UIButton that has a simple yet elegant appearance and built-in support for UIVisualEffectView and UIVibrancyEffect classes introduced in iOS 8. Yet, it can be used on iOS 7 without the vibrancy effect. The design of this button is inspired by "AYVibrantButton" by alan yip.
                       DESC
  s.homepage         = "https://github.com/remzr7/RZVibrantButton"
  s.screenshots      = "https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert-dark.gif?raw=true", "https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/translucent-dark.gif?raw=true"
  s.license          = {:type => 'MIT', :file => 'LICENSE'}
  s.author           = { "Rameez Remsudeen" => "remzr7@gmail.com" }
  s.source           = { :git => "https://github.com/remzr7/RZVibrantButton.git", :tag => '0.1.0' }
  s.social_media_url = 'https://twitter.com/remzr7'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
