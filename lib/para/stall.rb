require "para/stall/version"

require 'para'
require 'stall'
require 'simple_form'

require 'para/stall/inputs'

require 'para/stall/engine'

module Para
  module Stall
    extend ActiveSupport::Autoload

    autoload :VariantsPropertyConfig

    class << self
      def config(&block)
        if block
          block.call(self)
        else
          self
        end
      end

      def javascript_includes
        %w(para/stall)
      end

      def stylesheet_includes
        %w(para/stall)
      end
    end
  end
end
