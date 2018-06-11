module Slayer
  module Generators
    class ScaffoldGenerator < NamedBase
      desc "This generator creates a new Slayer::Commands and a corresponding Slayer::Form"

      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Command"

      argument :name, type: :string
      argument :fields, :type => :array, :required => false, :desc => "The attributes of the generated form. name:String completed:Boolean"

      def initialize(args, *options) #:nodoc:
        super
        @args = args
      end

      def create_command_files
        generate "slayer:command", "#{file_name}"
      end

      def create_form_files
        generate "slayer:form", "#{@args.join(" ")}"
      end

      def create_spec_files
      end

      def create_factory_files
      end
    end
  end
end
