# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'
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

target 'iNeoX' do

  pod 'Netmera', :path => '../ineo/.'
  pod 'GoogleTagManager', '~> 6.0'
  pod 'Firebase/Analytics'
end

target 'NotificationService' do
  netmera_notification_service_pod
end

target 'NotificationContent' do
  netmera_notification_content_pod
end

target 'NetmeraCarthage' do
  use_frameworks!
  netmera_pod
end

plugin 'cocoapods-keys', {
  :project => 'NetmeraSample',
  :target => 'iNeoX',
  :keys => [
    "NetmeraExampleAppAPIKey",
    "NetmeraIntegrationTestAPIKey",
    "NetmeraIntegrationTestRestAPIKey",
  ]
}
#
#pre_install do |installer|
#  installer.development_pod_targets.each do |target|
#    target.specs.each do |spec|
#      spec.attributes_hash.delete('public_header_files')
#    end
#  end
#end
