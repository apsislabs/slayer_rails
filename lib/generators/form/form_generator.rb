# frozen_string_literal: true

module Slayer
  module Generators
    class FormGenerator < NamedBase
      desc 'This generator creates new Slayer::Forms'

      source_root File.expand_path('templates', __dir__)
      check_class_collision suffix: 'Form'

      argument :name, type: :string
      argument :fields, type: :array, required: false,
                        desc: 'The attributes of the generated form. name:String completed:Boolean'

      def initialize(args, *options) # :nodoc:
        super
        args.shift
        @fields = args.map { |a| a.split(':') }
      end

      def create_form_files
        template 'form.rb', File.join('app', 'forms', class_path, "#{file_name}_form.rb")
      end
    end
  end
end
