# frozen_string_literal: true

module Slayer
  module Generators
    class ScaffoldGenerator < NamedBase
      desc 'This generator creates a new Slayer::Commands and a corresponding Slayer::Form'

      source_root File.expand_path('templates', __dir__)
      check_class_collision suffix: 'Command'

      argument :name, type: :string
      argument :fields, type: :array, required: false,
                        desc: 'The attributes of the generated form. name:String completed:Boolean'

      def initialize(args, *options) # :nodoc:
        super
        @args = args
      end

      def create_command_files
        generate 'slayer:command', file_name.to_s
      end

      def create_form_files
        generate 'slayer:form', @args.join(' ').to_s
      end
    end
  end
end
