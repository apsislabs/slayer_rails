require 'json'

module SlayerRails
  module Extensions
    module Form
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Validations

        def validate!
          return if valid?
          message = errors.full_messages.join(', ')
          raise Slayer::FormValidationError, message unless valid?
        end

        def as_model(klass, attr_map = nil)
          all_attrs = klass.new.attributes.keys.map(&:to_sym)
          return klass.new(attributes.slice(*all_attrs)) if attr_map.nil?
          attrs = attr_map.inject({}) do |memo, (key, val)|
            memo[key] = self.send(val)
            memo
          end
          klass.new(attrs)
        end

        class << self
          def from_params(params, additional_params: {}, root_key: nil)
            params     = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params.to_h
            params     = params.deep_symbolize_keys
            attr_names = attribute_set.map(&:name)

            params = params.fetch(root_key, {}) if root_key.present?

            attr_hash = params
                        .merge(params.slice(*attr_names))
                        .merge(additional_params)

            new(attr_hash)
          end

          def from_model(model)
            attr_hash = attribute_set.map(&:name)
                        .select { |attr_name| model.respond_to?(attr_name) }
                        .map    { |attr_name| [attr_name, model.public_send(attr_name)] }

            new(attr_hash.to_h)
          end

          def from_json(json)
            from_params(JSON.parse(json))
          end

          def validates_associated(*keys)
            self.validates_each(*keys) do |record, attr, value|
              unless value.valid?
                value.errors.each do |field, err_message|
                  record.errors.add(attr, "#{field} #{err_message}")
                end
              end
            end
          end
        end
      end
    end
  end
end
