namespace :tag_bearer do
  desc 'Explaining what the task does'
  task :migrate do
    cp 'lib/tasks/migration.rb', 'db/migrate/create_tag_bearer.rb'
  end
end
