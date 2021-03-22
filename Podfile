# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def common_pods
    use_frameworks!
    pod 'Alamofire', '~> 4.4'
    pod 'Kingfisher', '~> 4.8'
end

target 'Marvel Heroes' do
  common_pods

  # Pods for Marvel Heroes

  target 'Marvel HeroesTests' do
    inherit! :search_paths
    common_pods
  end

  target 'Marvel HeroesUITests' do
  common_pods
  end

end
