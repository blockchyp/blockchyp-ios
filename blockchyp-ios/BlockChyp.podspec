Pod::Spec.new do |s|
  s.name                           = 'BlockChyp'
  s.version                        = '2.0.0'
  s.summary                        = 'BlockChyp SDK for iOS Developers.'
  s.license                        = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage                       = 'https://github.com/blockchyp/blockchyp-ios'
  s.source                         = { :git => 'https://github.com/blockchyp/blockchyp-ios.git', :tag => "v#{s.version}" }
  s.frameworks                     = 'Foundation', 'CommonCrypto'
  s.requires_arc                   = true
  s.platform                       = :ios
  s.ios.deployment_target          = '8.0'
  s.public_header_files            = 'BlockChyp/*.h'
  s.source_files                   = 'BlockChyp/*.{h,m}'
  s.xcconfig = {
    "OTHER_LDFLAGS" => "$(inherited) -ObjC"
  }
end
