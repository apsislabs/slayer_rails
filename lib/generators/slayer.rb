require 'rails/generators/named_base'

module Slayer
  module Generators
    class Base < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __FILE__)

      def copy_command_file
        copy_file "command.rb", "commands/#{file_name}.rb"
      end
    end
  end
end
