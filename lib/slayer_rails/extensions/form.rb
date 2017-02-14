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

            root_key ||= param_key

            attr_hash = params
                        .fetch(root_key, {})
                        .merge(params.slice(*attr_names))
                        .merge(additional_params)

            new(attr_hash)
          end

          def from_model(model)
            attr_names = attribute_set.map(&:name)
            attr_hash = {}

            attr_names.each do |attr_name|
              attr_hash[attr_name] = model.public_send(attr_name) if model.respond_to?(attr_name)
            end

            new(attr_hash)
          end

          def from_json(json)
            from_params(JSON.parse(json))
          end

          def set_param_key(model_name)
            @model_name = model_name.to_s.underscore.to_sym
          end

          def param_key
            @model_name || infer_param_key
          end

          def infer_param_key
            class_name = name.split("::").last
            return :form if class_name == "Form"
            class_name.chomp("Form").underscore.to_sym
          end

          # Used by Rails to determine the path and param when
          # used with `form_for`
          def model_name
            ActiveModel::Name.new(self, nil, param_key.to_s.camelize)
          end
        end
      end
    end
  end
end
