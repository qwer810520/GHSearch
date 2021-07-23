source 'https://cdn.cocoapods.org/'

platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', generate_multiple_pod_projects: true

target 'GHSearch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GHSearch
  pod 'SwiftLint'
  pod 'Alamofire', '5.4.3'
  pod 'Nuke', '9.5.0'

  target 'GHSearchTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
