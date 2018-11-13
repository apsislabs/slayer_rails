module SlayerRails
  module Extensions
    module Translation
      extend ActiveSupport::Concern

      included do
        def translate(key, options={})
          I18n.translate(self.class.full_key(key), options.dup)
        end
        alias :t :translate


        def localize(*args)
          I18n.localize(*args)
        end
        alias :l :localize


        class << self
          def full_key(key)
            return key unless key.start_with? '.'

            return "#{implied_path}#{key}"
          end


          def implied_path
            @implied_path ||= build_implied_path
          end


          def build_implied_path
            module_path = self.name.split('::').map { |x| x.underscore }

            class_name_parts = module_path.pop.split('_')

            module_path.unshift(class_name_parts.pop.pluralize)
            module_path.push(class_name_parts.join('_'))

            module_path.join('.')
          end
        end
      end
    end
  end
end
