# frozen_string_literal: true

module IIFinder
  module Chain
    extend ActiveSupport::Concern

    included do
      class_attribute :_chains
      self._chains = []
    end

    def call
      lookup.each do |finder|
        merge_relation!(finder.call(*@_args))
      end
      super
    end

    def lookup
      self.class._chains.map do |finder|
        if finder.is_a?(Symbol) && respond_to?(finder, true)
          send(finder)
        elsif finder.is_a?(Proc)
          instance_exec(&finder)
        else
          finder
        end
      end.flatten.compact
    end

    class_methods do
      def chain(*finders, &block)
        self._chains = _chains + finders
        self._chains << block if block
      end
    end
  end
end
