$:.push File.expand_path('../lib', __FILE__)

require 'tag_bearer/version'

Gem::Specification.new do |s|
  s.name        = 'tag_bearer'
  s.version     = TagBearer::VERSION
  s.authors     = ['David Jellesma', 'Dan Jellesma']
  s.email       = ['davidjellesmas@gmail.com']
  s.homepage    = 'https://github.com/dsjellz/tag_bearer'
  s.summary     = 'This gem implements key/value tagging for ActiveRecord models using either mysql2 or postgresl adapter'
  s.description = 'Key value tagging gem for ActiveRecord models'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'activerecord', '~> 4.0'
  s.add_dependency 'rails', '~> 4.2'
  s.add_dependency 'rake', '~> 10.4'

  s.add_development_dependency 'database_cleaner', '~> 1.4'
  s.add_development_dependency 'mysql2', '~> 0.3'
  s.add_development_dependency 'pg', '~> 0.18'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  s.add_development_dependency 'rspec-its', '~> 1.2'
  s.add_development_dependency 'rspec-rails', '~> 3.2'

end
