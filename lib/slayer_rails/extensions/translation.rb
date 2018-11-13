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
            module_path = self.name.underscore.split('/')

            class_name_parts = module_path.pop.split('_')

            if ['command', 'service', 'form'].include? class_name_parts.last
              class_name_parts.pop
            end

            module_path.unshift(slayer_type)
            module_path.push(class_name_parts.join('_'))

            module_path.join('.')
          end

          def slayer_type
            @slayer_type ||= detect_slayer_type
          end

          def detect_slayer_type
            if self <= Slayer::Command
              return 'commands'
            elsif self <= Slayer::Service
              return 'services'
            elsif self <= Slayer::Form
              return 'forms'
            end
            raise NotImplementedException, "Unknown Slayer Class: #{self.name}"
          end
        end
      end
    end
  end
end
