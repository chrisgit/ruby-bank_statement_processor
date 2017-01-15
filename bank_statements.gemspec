# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'bank_statements'
  gem.version       = BankStatements::VERSION
  gem.date          = '2017-01-12'
  gem.summary       = 'Basic processing engine for Natwest Bank Statements'
  gem.description   = 'Basic processing engine for Natwest Bank Statements'
  gem.authors       = ['Chris Sullivan']
  gem.email         = ['']
  gem.homepage      = ''

  gem.files         = Dir['{lib}/**/*', 'README*', 'LICENSE*']
  gem.require_paths = ['lib']
  gem.license       = 'MIT'
end
