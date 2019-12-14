Pod::Spec.new do |spec|
  spec.name         = "SpreadsheetClient"
  spec.version      = "0.0.1"
  spec.summary      = "Get the value of a Google spreadsheet file"
  spec.homepage     = "https://github.com/t-osawa-009/SpreadsheetClient"
  spec.license      = "MIT"
  spec.author       = { "t-osawa-009" => "da87435@gmail.com" }
  spec.source       = { :git => "https://github.com/t-osawa-009/SpreadsheetClient.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/*.swift"
  spec.ios.deployment_target = "10.0"
  spec.tvos.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  spec.watchos.deployment_target = "3.0"
  spec.requires_arc = true
  spec.swift_version = "5.1"
end
