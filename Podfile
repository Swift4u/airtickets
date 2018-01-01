platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target 'airtickets' do
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireObjectMapper', '~> 5.0'
    pod 'ObjectMapper', '~> 3.0'
    pod 'UIColor_Hex_Swift', '~> 3.0.1'
    pod 'ReachabilitySwift', '~> 3'
    pod 'Localize-Swift', '~> 1.6'
end

target 'airticketsTests' do
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireObjectMapper', '~> 5.0'
    pod 'ObjectMapper', '~> 3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
