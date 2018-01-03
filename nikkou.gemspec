$:.push File.expand_path('../lib', __FILE__)
require 'nikkou/version'

Gem::Specification.new do |s|
  s.name        = 'nikkou'
  s.version     = Nikkou::VERSION
  s.authors     = ['Tom Benner']
  s.email       = ['tombenner@gmail.com']
  s.homepage    = 'https://github.com/tombenner/nikkou'
  s.summary = s.description = 'Extract useful data from HTML and XML with ease!'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'nokogiri'
  s.add_dependency 'activesupport'
  s.add_dependency 'tzinfo'
  s.add_dependency 'amatch'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
