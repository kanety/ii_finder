# frozen_string_literal: true

module IIFinder
  module Lookup
    extend ActiveSupport::Concern

    included do
      class_attribute :_model
    end

    class_methods do
      def model(model)
        self._model = model
      end

      def lookup(klass = self)
        _model || Lookup.call(klass)
      end
    end

    class << self
      class_attribute :_cache
      self._cache = {}

      def call(klass)
        return if terminate?(klass)

        cache(klass) do
          if klass.name && (resolved = resolve(klass))
            resolved
          elsif klass.superclass
            call(klass.superclass)
          end
        end
      end

      private

      def cache(klass)
        if Config.lookup_cache
          self._cache[klass] ||= yield
        else
          yield
        end
      end

      def terminate?(klass)
        klass.name.to_s.in?(['IIFinder::Base', 'ActiveRecord::Base'])
      end

      def resolve(klass)
        resolved_name = if klass < IIFinder::Base
            klass.name.sub(/Finder$/, '').singularize
          else
            klass.name.pluralize + 'Finder'
          end
        resolved = resolved_name.safe_constantize
        return resolved if resolved && resolved_name == resolved.name
      end
    end
  end
end
