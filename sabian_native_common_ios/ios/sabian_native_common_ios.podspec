#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sabian_native_common_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sabian_native_common_ios'
  s.version          = '0.0.1'
  s.summary          = 'IOS implementation of the sabian_native_common plugin'
  s.description      = <<-DESC
IOS implementation of the sabian_native_common plugin
                       DESC
s.homepage         = 'https://github.com/bryosabian/sabian_flutter_native_common'
s.license          = { :file => '../LICENSE' }
s.author           = { 'Sabian Technologies' => 'sabianbryococ@gmail.com' }
s.source           = { :path => '.' }
s.source_files = 'Classes/**/*'
s.dependency 'Flutter'

s.dependency 'YPImagePicker'
s.dependency 'SPPermissions'

s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
