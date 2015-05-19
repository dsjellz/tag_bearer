$:.push File.expand_path('../lib', __FILE__)

require 'tag_bearer/version'

Gem::Specification.new do |s|
  s.name        = 'tag_bearer'
  s.version     = TagBearer::VERSION
  s.authors     = ['David Jellesma', 'Dan Jellesma']
  s.email       = ['davidjellesmas@gmail.com']
  s.homepage    = 'https://github.com/dsjellz/acts_as_tag_bearer'
  s.summary     = 'Key value tagging gem for ActiveRecord models'
  s.description = 'Key value tagging gem for ActiveRecord models'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  # s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'rake'
  s.add_dependency 'rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-its'
  s.add_dependency 'activerecord', '~> 4.0'

end
