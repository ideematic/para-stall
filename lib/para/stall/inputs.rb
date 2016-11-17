module Para
  module Stall
    module Inputs
      extend ActiveSupport::Autoload

      autoload :VariantsMatrixInput
    end
  end
end

SimpleForm.custom_inputs_namespaces << 'Para::Stall::Inputs'
