# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "wildcard_finders"
  gem.version       = File.read(File.join(File.dirname(__FILE__), "VERSION")).chomp
  gem.authors       = ["okitan"]
  gem.email         = ["okitakunio@gmail.com"]
  gem.description   = "finders for capybara"
  gem.summary       = "finders for people strugling non-semantic doms"
  gem.homepage      = "https://github.com/okitan/wildcard_finders"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capybara"
  gem.add_dependency "wildcard_matchers"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "sinatra"
  gem.add_development_dependency "slim"
end
