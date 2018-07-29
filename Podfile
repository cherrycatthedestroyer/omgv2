# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
    pod 'Firebase/Database'
    pod 'Firebase/Core'
    pod 'Charts'
    pod 'Firebase/Auth'
end

target 'insupal[version1]' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  shared_pods

  target 'insupal[version1]Tests' do
    inherit! :search_paths
    # Pods for testing
  end

end
