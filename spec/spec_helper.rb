require 'codeclimate-test-reporter'
require 'rspec/collection_matchers'

CodeClimate::TestReporter.start

$LOAD_PATH << '.' unless $LOAD_PATH.include?('.')
$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require File.expand_path('../../lib/tag_bearer', __FILE__)

require 'database_cleaner'

postgres = {adapter: 'postgresql', database: 'tag_bearer', username: 'postgres'}
mysql = {adapter: 'mysql2', database: 'tag_bearer'}

[postgres, mysql].each do |connection_data|
  ActiveRecord::Base.establish_connection(connection_data)
  ActiveRecord::Schema.define do
    self.verbose = false

    create_table(:tags) do |t|
      t.string :key
      t.string :value
      t.references :taggable, polymorphic: true, index: true
      t.timestamps null: false
    end unless table_exists?(:tags)

    create_table :taggable_model, :force => true do |t|
      t.timestamps null: false
    end unless table_exists?(:taggable_model)

    create_table :another_taggable_model, :force => true do |t|
      t.timestamps null: false
    end unless table_exists?(:another_taggable_model)
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



