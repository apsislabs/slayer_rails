module Slayer
  module Generators
    class CommandGenerator < Slayer::Generators::Base
      desc "This generator creates new Slayer::Commands"
      source_root File.expand_path("../../templates", __FILE__)

      def copy_command_file
        copy_file "command.rb", "commands/#{file_name}.rb"
      end
    end
  end
end
