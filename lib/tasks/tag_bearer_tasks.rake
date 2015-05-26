namespace :tag_bearer do
  desc 'Explaining what the task does'
  task :create_migration do
    cp 'lib/tasks/migration.rb', 'db/migrate/create_tag_bearer.rb'
  end
end
