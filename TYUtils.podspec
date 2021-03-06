Pod::Spec.new do |s|
  s.name             = 'TYUtils'
  s.version          = '0.2.1'
  s.summary          = 'Simple iOS framework adding helpers and extensions'
  s.description      = <<-DESC
                       A set of iOS helpers and extensions to help writing smart, robust, clear and perfomant code.
                       DESC
  s.homepage         = 'https://github.com/OlivierVoyer/TYUtils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Olivier Voyer' => 'olivier@tekiteazy.com' }
  s.source           = { :git => 'https://github.com/OlivierVoyer/TYUtils.git', :tag => s.version.to_s }
  # Commented due to https://github.com/CocoaPods/CocoaPods/issues/10291
  # s.social_media_url = 'https://twitter.com/TekITEazyFrance'

  # Platform setup
  s.ios.deployment_target = '12.0'
  s.swift_version = ['5.0', '5.1', '5.2']

  s.default_subspec = 'Core'

  # Subspecs

  s.subspec 'Core' do |cs|
      cs.dependency 'TYUtils/PropertyWrappers'
      cs.dependency 'TYUtils/Extensions'
  end

  s.subspec 'PropertyWrappers' do |pws|
      pws.source_files   = 'Sources/Property Wrappers/Classes/**/*.{swift}'
      pws.frameworks     = 'Foundation'
      pws.dependency       'KeychainSwift', '~> 19.0.0'
  end

  s.subspec 'Extensions' do |es|
      es.source_files   = 'Sources/Extensions/Classes/**/*.{swift}'
      es.frameworks     = 'Foundation'
  end
end
