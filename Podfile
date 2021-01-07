platform :ios, '13.0'

target 'FuddApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FuddApp
   pod 'SwiftLint'
   pod 'Kingfisher'
   pod 'Moya'
   pod 'PromiseKit'
   pod 'SlideMenuControllerSwift'
end

   post_install do |installer|

     installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
               if ['SlideMenuControllerSwift'].include? target.name
                   config.build_settings['SWIFT_VERSION'] = '4.0'
               end

           end
       end
   end

