module Slayer
  module Generators
    class ScaffoldGenerator < NamedBase
      desc "This generator creates a new Slayer::Commands and a corresponding Slayer::Form"

      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Command"

      def create_command_files
        generate "slayer:command", "#{file_name}"
      end

      def create_form_files
        generate "slayer:form", "#{file_name}"
      end
    end
  end
end
