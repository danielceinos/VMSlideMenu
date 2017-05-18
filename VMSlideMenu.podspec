Pod::Spec.new do |s|
  s.name             = 'VMSlideMenu'
  s.version          = '0.1.0'
  s.summary          = 'VMSlideMenu allows add a beautyful and intuitive menu to your app. You can organize options in tabs and rows.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Jorge Lucena/VMSlideMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jorge Lucena' => 'jmlucena@vectoritcgroup.com' }
  s.source           = { :git => 'https://github.com/Jorge Lucena/VMSlideMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VMSlideMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VMSlideMenu' => ['VMSlideMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
