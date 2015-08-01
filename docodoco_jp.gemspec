# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docodoco_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "docodoco_jp"
  spec.version       = DocodocoJp::VERSION
  spec.authors       = ["Hiroshi IKEGAMI"]
  spec.email         = ["hiroshi.ikegami@magicdrive.jp"]

  spec.summary       = %q{Location service www.docodoco.jp API Client.}
  spec.description   = %q{Location service www.docodoco.jp API Client.}
  spec.homepage      = "https://github.com/magicdrive/ruby-docodoco_jp"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.0"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "hashie", "~> 3.0"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
