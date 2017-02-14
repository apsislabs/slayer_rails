require 'json'

module SlayerRails
  module Extensions
    module Form
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Validations

        def validate!
          raise Slayer::FormValidationError, errors unless valid?
        end

        class << self
          def from_params(params, additional_params: {}, root_key: nil)
            params     = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params.to_h
            params     = params.deep_symbolize_keys
            attr_names = attribute_set.map(&:name)

            attr_hash = params
                          .fetch(root_key, {})
                          .merge(params.slice(*attr_names))
                          .merge(additional_params)

            new(attr_hash)
          end

          def from_model(model)
            attr_names = attribute_set.map(&:name)

            attr_hash = attr_names.inject({}) do |n, hash|
              hash[n] = model.public_send(n) if model.respond_to?(n)
            end

            new(attr_hash)
          end

          def from_json(json)
            from_params(JSON.parse(json))
          end
        end
      end
    end
  end
end
