# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MoviesApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
   pod 'MSPeekCollectionViewDelegateImplementation'
   pod 'MarqueeLabel'
   pod 'Switches'
   pod 'YALSideMenu', '~> 2.0.1'
   pod "RevealMenuController"	
	
  # Pods for Movies App

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
  end
 end
end

end

