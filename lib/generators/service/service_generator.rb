module Slayer
  module Generators
    class ServiceGenerator < NamedBase
      desc "This generator creates new Slayer::Services"

      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Service"

      def create_service_files
        template "service.rb", File.join("app", "services", class_path, "#{file_name}_service.rb")
      end
    end
  end
end
