# frozen_string_literal: true

module IIFinder
  module Core
    extend ActiveSupport::Concern

    included do
      attr_reader :relation, :criteria, :model, :table
    end

    def initialize(*args)
      if args.size == 0 || args.size == 1
        @model = self.class.lookup
        raise IIFinder::Error.new("could not find model for #{self.class}") unless @model
        @relation = @model.all
        @criteria = args[0] || {}
      else
        @relation = args[0]
        @criteria = args[1]
        @model = @relation.klass
      end
      @table = @model.arel_table
    end

    def call
      self.class._parameters.each do |param|
        value = fetch_criteria(param.name)
        if value.present? || param.allow_blank?
          call_method(param.name, value)
        end
      end

      @relation
    end

    def fetch_criteria(name)
      if @criteria.respond_to?(name)
        @criteria.send(name)
      elsif @criteria.respond_to?(:fetch)
        @criteria.fetch(name, nil)
      end
    end

    def call_method(name, value)
      result = send(name, value)

      if Config.merge_relation && result.is_a?(ActiveRecord::Relation)
        @relation = @relation.merge(result)
      end
    end

    class_methods do
      def call(*args)
        new(*args).call
      end
    end
  end
end