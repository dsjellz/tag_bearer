require 'rails/generators'
require 'rails/generators/migration'

module TagBearer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Create migrations for TagBearer'

      def copy_migrations
        copy_migration 'create_tags'
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime('%Y%m%d%H%M%S').to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      protected

      def copy_migration(filename)
        if self.class.migration_exists?('db/migrate', "#{filename}")
          say_status('skipped', "Migration #{filename}.rb already exists")
        else
          migration_template "#{filename}.rb", "db/migrate/#{filename}.rb"
        end
      end

    end
  end

end