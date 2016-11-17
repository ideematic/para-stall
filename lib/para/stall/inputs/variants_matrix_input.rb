module Para
  module Stall
    module Inputs
      class VariantsMatrixInput < SimpleForm::Inputs::Base
        def input(wrapper_options = nil)
          ensure_target_relation_present!

          puts "Reordered variants : #{ variants.map(&:name).inspect }"

          template.render partial: 'para/stall/inputs/variants_matrix', locals: {
            form: @builder,
            model: model,
            attribute_name: attribute_name,
            properties: properties,
            variants: variants,
            require_all_properties: require_all_properties,
            dom_identifier: dom_identifier,
            variant_row_locals: variant_row_locals
          }
        end

        private

        def resource
          @resource ||= @builder.object
        end

        def model
          @model ||= resource.class
        end

        def properties
          @properties ||= options[:properties].map do |property_name, model_name|
            VariantsPropertyConfig.new(resource, property_name, relation: attribute_name, model_name: model_name)
          end
        end

        def variants
          @variants ||= resource.send(attribute_name).sort_by(&method(:variant_sort_method))
        end

        def require_all_properties
          options[:require_all_properties] || false
        end

        def dom_identifier
          @dom_identifier ||= [
            model.model_name.element,
            resource.id || resource.object_id,
            attribute_name
          ].join('-')
        end

        def variant_row_locals
          {
            model: model,
            attribute_name: attribute_name,
            properties: properties,
            dom_identifier: dom_identifier
          }
        end

        def variant_sort_method(variant)
          sort_key = properties.map do |property_config|
            property = variant.send(property_config.property_name)
            property_config.property_name_for(property).try(:parameterize)
          end.join(':')

          puts "Sort key \"#{ sort_key }\" for variant : #{ variant.inspect }"
          sort_key
        end

        # Raises a comprehensive error for easy wrong form attribute catching
        #
        def ensure_target_relation_present!
          unless model.reflect_on_association(attribute_name)
            raise NoMethodError,
              "Relation ##{ attribute_name } does not exist for model #{ model.name }."
          end
        end
      end
    end
  end
end
