
Pod::Spec.new do |spec|

  spec.name         = "SwiftyStars"
  spec.version      = "0.0.3"
  spec.summary      = "A view with stars to use for ratings."

  spec.description  = <<-DESC
A simple view to add a stars rating to your app.
                   DESC

  spec.homepage     = "https://github.com/hujaber/SwiftyStars"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "Hussein Jaber" => "hujaber@me.com" }
  spec.platform     = :ios, "11.0"
  spec.ios.deployment_target = "11.0"


  spec.source       = { :git => "https://github.com/hujaber/SwiftyStars.git", :tag => "#{spec.version}" }




  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"
  spec.source_files  = "SwiftyStars/**/*.{h,swift}"
  spec.resources = "SwiftyStars/**/Assets.xcassets"
  spec.exclude_files = "SwiftStars/**/*.plist"
  spec.swift_versions = "5.0"
  spec.framework = "UIKit"

end
