# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

target 'NetmeraSample' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for NetmeraSample
  pod 'Netmera'

  target 'NetmeraSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
end


target 'NetmeraSampleNotificationContentExtension' do

  pod 'Netmera/NotificationContentExtension'

end

target 'NetmeraSampleNotificationServiceExtension' do

  pod 'Netmera/NotificationServiceExtension'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
