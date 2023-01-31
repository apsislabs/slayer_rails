# frozen_string_literal: true

module Slayer
  module Generators
    class CommandGenerator < NamedBase
      desc 'This generator creates new Slayer::Commands'

      source_root File.expand_path('templates', __dir__)
      check_class_collision suffix: 'Command'

      def create_command_files
        template 'command.rb', File.join('app', 'commands', class_path, "#{file_name}_command.rb")
      end
    end
  end
end
