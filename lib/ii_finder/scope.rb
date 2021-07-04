# frozen_string_literal: true

module IIFinder
  module Scope
    extend ActiveSupport::Concern

    class_methods do
      def finder_scope(criteria)
        finder = IIFinder::Lookup.call(self)
        raise IIFinder::Error.new("could not find finder for #{self}") unless finder
        finder.call(criteria)
      end
    end
  end
end
