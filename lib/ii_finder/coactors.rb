# frozen_string_literal: true

module IIFinder
  module Coactors
    extend ActiveSupport::Concern

    included do
      include Coactive::Base

      configure_coactive do |config|
        config.load_paths = ['app/finders']
        config.class_suffix = 'Finder'
        config.use_cache = true
        config.lookup_superclass_until = ['ActiveRecord::Base', 'ActiveModel::Base']
      end

      class << self
        alias_method :chain, :coact
      end
    end
  end
end
