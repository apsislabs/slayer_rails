require "rails/generators/rails/model/model_generator"

module Slayer
  module Generators
    class FormGenerator < Rails::Generators::ModelGenerator
      desc "This generator creates new Slayer::Forms"

      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Form"

      def create_form_files
        template "form.rb", File.join("app", "forms", class_path, "#{file_name}_form.rb")
      end
    end
  end
end
