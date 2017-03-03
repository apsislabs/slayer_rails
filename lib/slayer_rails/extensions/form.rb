require 'json'

module SlayerRails
  module Extensions
    module Form
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Model

        def validate!
          raise Slayer::FormValidationError, errors unless valid?
        end

        class << self
          def from_params(params, additional_params: {}, root_key: nil)
            params     = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params.to_h
            params     = params.deep_symbolize_keys
            attr_names = attribute_set.map(&:name)

            root_key ||= param_key

            attr_hash = params
                        .fetch(root_key, {})
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
        end
      end
    end
  end
end
