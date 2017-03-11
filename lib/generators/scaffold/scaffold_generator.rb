def genlog(str)
  `echo "#{str}" >> genlog`
end

module Slayer
  module Generators
    class ScaffoldGenerator < NamedBase
      desc "This generator creates a new Slayer::Commands and a corresponding Slayer::Form"

      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Command"

      argument :name, type: :string
      argument :fields, :type => :array, :required => false, :desc => "The attributes of the generated form. name:String completed:Boolean"

      def initialize(args, *options) #:nodoc:
        genlog "s1: #{args.inspect}"
        super
        genlog "s2: #{args.inspect}"
        @args = args
        genlog "s3: #{@args.inspect}"
      end

      def create_command_files
        generate "slayer:command", "#{file_name}"
      end

      def create_form_files
        genlog "slayer:scaffold:create_form_files"
        genlog "#{@args.inspect}"
        genlog "#{@args.join(" ")}"
        generate "slayer:form", "#{@args.join(" ")}"
      end
    end
  end
end
