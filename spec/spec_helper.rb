require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH << '.' unless $LOAD_PATH.include?('.')
$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require File.expand_path('../../lib/tag_bearer', __FILE__)

require 'database_cleaner'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.define do
  self.verbose = false

  create_table(:tags) do |t|
    t.string :key
    t.string :value
    t.references :taggable, polymorphic: true, index: true
    t.timestamps null: false
  end

  create_table :taggable_model, :force => true do |t|
    t.timestamps null: false
  end
end

Dir['./spec/support/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end



