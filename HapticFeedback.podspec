Pod::Spec.new do |spec|
  spec.name          = 'HapticFeedback'
  spec.version       = '0.0.1'
  spec.license       = 'MIT'
  spec.authors       = { 'Alexandr Lezya' => '1ezya007@gmail.com' }
  spec.homepage      = "https://github.com/Incetro/incetro-pod-template.git"
  spec.summary       = 'HapticFeedback - easy to use haptic feedback generator with pattern-play support'
  spec.platform      = :ios, "11.0"
  spec.swift_version = '4.0'
  spec.source        = { git: "https://github.com/Incetro/incetro-pod-template.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/HapticFeedback/**/*"
end