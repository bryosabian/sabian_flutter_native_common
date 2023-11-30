#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sabian_native_common.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sabian_native_common'
  s.version          = '0.0.1'
  s.summary          = 'Common native utils'
  s.description      = <<-DESC
Common native utils
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  
  s.dependency 'YPImagePicker'
  s.dependency 'SPPermissions/Camera'
  s.dependency 'SPPermissions/PhotoLibrary'
  s.dependency 'SPPermissions/Siri'
  s.dependency 'SPPermissions/Health'
  s.dependency 'SPPermissions/Notification'
  s.dependency 'PermissionsKit/CameraPermission'
  s.dependency 'PermissionsKit/PhotoLibraryPermission'
  s.dependency 'PermissionsKit/SiriPermission'
  s.dependency 'PermissionsKit/HealthPermission'
  s.dependency 'PermissionsKit/NotificationPermission'
  
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
