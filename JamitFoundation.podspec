Pod::Spec.new do |spec|

  spec.name          = "JamitFoundation"
  spec.version       = "1.4.1"
  spec.summary       = "JamitFoundation is a collection of useful concepts to enable composition oriented development with UIKit."
  spec.homepage      = "https://github.com/JamitLabs/JamitFoundation"
  spec.license       = { :type => 'MIT' }
  spec.author        = { "Jamit Labs GmbH" => "mail@jamitlabs.com" }
  spec.platform      = :ios, "9.0"
  spec.swift_version = "5.0"
  spec.source        = { :git => "https://github.com/JamitLabs/JamitFoundation.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.{h,m,swift}"

end
