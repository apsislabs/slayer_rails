# source: https://gist.github.com/schickling/6762581

require 'slayer_rails'
require 'active_record'
require 'yaml'

GEM_ROOT      = File.dirname( __dir__ )
DB_CONFIG     = YAML.load(File.open('test/sample/config/database.yml'))
SCHEMA_FILE   = "#{GEM_ROOT}/test/sample/db/schema.rb"
MIGRATION_DIR = "#{GEM_ROOT}/test/sample/db/migrate"

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(DB_CONFIG)
    ActiveRecord::Migrator.migrate(MIGRATION_DIR)
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Create a db/schema.rb file that is portable against any supported DB"
  task :schema do
    ActiveRecord::Base.establish_connection(DB_CONFIG)
    require 'active_record/schema_dumper'

    File.open(SCHEMA_FILE, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end
end


namespace :g do
  desc "Generate migration"
  task :migration do
    name      = ARGV[1] || raise("Specify name: rake g:migration name")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path      = File.expand_path("#{MIGRATION_DIR}/#{timestamp}_#{name}.rb", __FILE__)

    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, "w") do |file|
      file.write <<-EOF.strip_heredoc
        class #{migration_class} < ActiveRecord::Migration
          def change
          end
        end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
