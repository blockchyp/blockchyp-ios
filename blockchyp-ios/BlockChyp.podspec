Pod::Spec.new do |spec|

  spec.name                        = "BlockChyp"
  spec.version                     = "2.14.0"
  spec.summary                     = "BlockChyp SDK for iOS Developers."
  spec.description                 = <<-DESC
    This is the SDK for iOS. Like all BlockChyp SDKs, it provides a full
    client for the BlockChyp gateway and BlockChyp payment terminals. The SDK is
    written in Objective-C, but can be used by Swift developers as well.
  DESC
  spec.homepage                    = "https://www.blockchyp.com"
  spec.license                     = { :type => "MIT", :file => "LICENSE" }
  spec.author                      = { "BlockChyp" => "support@blockchyp.com" }
  spec.source                      = { :git => "https://github.com/blockchyp/blockchyp-ios.git", :tag => "v#{spec.version}" }
  spec.frameworks                  = "Foundation"
  spec.requires_arc                = true
  spec.platform                    = :ios
  spec.ios.deployment_target       = "8.0"
  spec.source_files                = "blockchyp-ios/BlockChyp/*.{h,m}"
  spec.public_header_files         = "blockchyp-ios/BlockChyp/*.h"
  spec.xcconfig = {
    "OTHER_LDFLAGS" => "$(inherited) -ObjC"
  }

end
