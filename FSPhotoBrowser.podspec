
Pod::Spec.new do |s|
  s.name      = 'FSPhotoBrowser'
  s.version   = '1.0.0'
  s.summary   = 'A short description of FSPhotoBrowser.'
  s.homepage  = 'https://github.com/lifution'
  s.license   = { :type => 'MIT', :file => 'LICENSE' }
  s.author    = 'AllenLee'
  s.source    = {
    :git => 'git@github.com:lifution/FSPhotoBrowser.git',
    :tag => s.version.to_s
  }
  
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.frameworks = 'UIKit', 'Foundation'

  s.source_files = 'FSPhotoBrowser/Classes/**/*'
  
  s.resources = [
    'FSPhotoBrowser/Assets/FSPhotoBrowser.bundle'
  ]
end
