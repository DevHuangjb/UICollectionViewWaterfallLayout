Pod::Spec.new do |s|
s.name        = 'UICollectionViewWaterfallLayout'
s.version     = '1.0.1'
s.authors     = { 'DevHuangjb' => 'example@example.com' }
s.homepage    = 'https://github.com/DevHuangjb/UICollectionViewWaterfallLayout'
s.summary     = 'a waterfall layout for UICollectionView'
s.source      = { :git => 'https://github.com/DevHuangjb/UICollectionViewWaterfallLayout.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '9.0'
s.requires_arc = true
s.source_files = 'WaterfallLayout/layout/*'
s.public_header_files = 'WaterfallLayout/layout/*.h'

s.ios.deployment_target = '7.0'
end