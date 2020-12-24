# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docodoco_jp/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.6.0'
  spec.name          = "docodoco_jp"
  spec.version       = DocodocoJp::VERSION
  spec.authors       = ["Hiroshi IKEGAMI"]
  spec.email         = ["hiroshi.ikegami@magicdrive.jp"]

  spec.summary       = %q{Location service www.docodoco.jp API Client.}
  spec.description   = %q{Location service www.docodoco.jp API Client.}
  spec.homepage      = "https://github.com/magicdrive/ruby-docodoco_jp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", '~> 1.0'
  spec.add_dependency "faraday", "~> 1.0"
  spec.add_dependency "hashie", "~> 4.1.0"

  spec.add_development_dependency "minitest", "~> 5.14"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
