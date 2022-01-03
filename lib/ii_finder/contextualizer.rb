# frozen_string_literal: true

module IIFinder
  module Contextualizer
    extend ActiveSupport::Concern
    include Coactive::Contextualizer

    def call
      contextualize do
        super
      end
    end
  end
end
