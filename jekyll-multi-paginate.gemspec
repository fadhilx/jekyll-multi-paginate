# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/multi/paginate/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-multi-paginate"
  spec.version       = Jekyll::Multi::Paginate::VERSION
  spec.authors       = ["Fadhil Napis"]
  spec.email         = ["fadzbobby95@gmail.com"]

  spec.summary       = %q{Another jekyll pagination plugins}
  spec.description   = %q{This plugins will allows you to create page pagination to multiple page, you also be able to sort something by category or language}
  spec.homepage      = "https://github.com/fadhilnapis/jekyll-multi-paginate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "jekyll", ">= 3.0"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
