# frozen_string_literal: true

require_relative 'parameter'

module IIFinder
  module Parameters
    extend ActiveSupport::Concern

    included do
      class_attribute :_parameters
      self._parameters = []
    end

    class_methods do
      def parameters(*names, **options)
        names.each do |name|
          self._parameters = _parameters + [Parameter.new(name, options)]
        end
      end
    end
  end
end
