Pod::Spec.new do |spec|

  spec.name         = "BlokID-iOS-Netset"
  spec.version      = "1.0.0"
  spec.summary      = "This is the best device analytics framework."
  spec.description  = "This is the best analytics framework"

  spec.homepage     = "https://github.com/Mprogrammer2020/BlokID-iOS-Netset"
  spec.license      = "MIT"
  spec.author             = { "Tajinder Singh" => "tajinder.singh@netsetsoftware.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/Mprogrammer2020/BlokID-iOS-Netset.git", :tag => spec.version.to_s }

  spec.source_files  = "BlokID-iOS-Netset/**/*.{swift}"
  spec.swift_version = "5.0"
end
