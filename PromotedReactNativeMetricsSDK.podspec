# Be sure to run `pod lib lint PromotedReactNativeMetricsSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# https://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name             = 'PromotedReactNativeMetricsSDK'
  s.version          = '0.0.1'
  s.summary          = 'iOS React Native client library for Promoted.ai metrics tracking.'
  
  s.description      = <<-DESC
  iOS React Native client library for Promoted.ai metrics tracking.
  DESC
  
  s.homepage         = 'https://github.com/promotedai/ios-react-native-metrics-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yu-Hong Wang' => 'yu-hong@promoted.ai' }
  s.source           = { :git => 'https://github.com/promotedai/ios-react-native-metrics-sdk.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  
  s.source_files = ['Sources/PromotedReactNativeMetricsSDK/**/*.{h,m,swift}']
  s.swift_version = '5.2'

  s.dependency 'PromotedAIMetricsSDK'
  s.dependency 'React-Core'
end
