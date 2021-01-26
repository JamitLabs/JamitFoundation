Pod::Spec.new do |spec|

  spec.name          = "JamitFoundation"
  spec.version       = "1.4.2"
  spec.summary       = "JamitFoundation is a collection of useful concepts to enable composition oriented development with UIKit."
  spec.homepage      = "https://github.com/JamitLabs/JamitFoundation"
  spec.license       = { :type => 'MIT' }
  spec.author        = { "Jamit Labs GmbH" => "mail@jamitlabs.com" }
  spec.platform      = :ios, "9.0"
  spec.swift_version = "5.0"
  spec.source        = { :git => "https://github.com/JamitLabs/JamitFoundation.git", :tag => "#{spec.version}" }

  spec.subspec 'Core' do |sp|
    sp.source_files  = "Sources/**/*.{h,m,swift}"
  end

  spec.subspec 'BarcodeScanner' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/BarcodeScanner'
  end

  spec.subspec 'CarouselView' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/CarouselView'
  end

  spec.subspec 'GridView' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/GridView'
  end

  spec.subspec 'PageView' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/PageView'
  end

  spec.subspec 'TimePickerView' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/TimePickerView'
  end

  spec.subspec 'WeakCache' do |sp|
    sp.dependency 'JamitFoundation/Core'
    sp.source_files = 'Modules/WeakCache'
  end

end