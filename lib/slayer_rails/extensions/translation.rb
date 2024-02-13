# frozen_string_literal: true

module SlayerRails
  module Extensions
    module Translation
      extend ActiveSupport::Concern

      # rubocop:disable Metrics/BlockLength
      included do
        def translate(key, **options)
          I18n.translate(self.class.full_key(key), **options)
        end
        alias_method :t, :translate

        def localize(*args, **kwargs)
          I18n.localize(*args, **kwargs)
        end
        alias_method :l, :localize

        class << self
          def full_key(key)
            return key unless key.start_with? '.'

            "#{implied_path}#{key}"
          end

          def implied_path
            @implied_path ||= build_implied_path
          end

          def build_implied_path
            module_path = name.underscore.split('/')

            class_name_parts = module_path.pop.split('_')

            class_name_parts.pop if %w[command service form].include? class_name_parts.last

            module_path.unshift(slayer_type)
            module_path.push(class_name_parts.join('_'))

            module_path.join('.')
          end

          def slayer_type
            @slayer_type ||= detect_slayer_type
          end

          def detect_slayer_type
            return 'commands' if self <= Slayer::Command
            return 'forms' if self <= Slayer::Form

            raise NotImplementedException, "Unknown Slayer Class: #{name}"
          end
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
