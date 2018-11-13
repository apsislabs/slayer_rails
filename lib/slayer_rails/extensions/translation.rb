module SlayerRails
  module Extensions
    module Translation
      extend ActiveSupport::Concern

      included do
        def translate(key, options={})
          I18n.translate(full_key(key), options.dup)
        end
        alias :t :translate

        def localize(*args)
          I18n.localize(*args)
        end
        alias :l :localize

        private

        def full_key(key)
          return key unless key.start_with? '.'

          module_path = self.class.name
            .split("::")
            .map { |x| x.underscore }

          class_name_parts = module_path.pop.split("_")

          module_path.unshift(class_name_parts.pop.pluralize)
          module_path.push(class_name_parts.join('_'))

          return "#{module_path.join(".")}#{key}"
        end
      end
    end
  end
end
