# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

#use_frameworks!

def netmera_pod
  pod 'Netmera', :path => '../ineo/.'
end

def netmera_notification_service_pod
  pod 'Netmera/NotificationServiceExtension', :path => '../ineo/.'
end

def netmera_notification_content_pod
  pod 'Netmera/NotificationContentExtension', :path => '../ineo/.'
end

target 'NetmeraSample' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for NetmeraSample
  netmera_pod

  target 'NetmeraSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
end


target 'NetmeraSampleNotificationContentExtension' do

  netmera_notification_content_pod

end

target 'NetmeraSampleNotificationServiceExtension' do

  netmera_notification_service_pod

end

target 'iNeoX' do

  pod 'Netmera', :path => '../ineo/.'
  pod 'GoogleTagManager', '~> 6.0'
  pod 'Firebase/Analytics'
end

plugin 'cocoapods-keys', {
  :project => 'Netmera',
  :target => 'iNeoX',
  :keys => [
    "NetmeraExampleAppAPIKey",
    "NetmeraIntegrationTestAPIKey",
    "NetmeraIntegrationTestRestAPIKey",
  ]
}
