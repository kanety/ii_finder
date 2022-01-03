# frozen_string_literal: true

module IIFinder
  module Core
    extend ActiveSupport::Concern

    included do
      attr_reader :relation, :criteria, :model, :table
    end

    def initialize(*args)
      @_args = args;
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
      @table = @model.arel_table if @model.respond_to?(:arel_table)
    end

    def call_all
      coactors.each do |finder|
        merge_relation!(finder.call(*@_args))
      end
      call
    end

    def call
      self.class._parameters.each do |param|
        value = fetch_criteria(param.name)
        if value.present? || param.allow_blank?
          merge_relation!(send(param.name, value))
        end
      end

      @relation
    end

    def fetch_criteria(name)
      if @criteria.respond_to?(:fetch)
        @criteria.fetch(name, nil)
      elsif @criteria.respond_to?(name)
        @criteria.send(name)
      end
    end

    def merge_relation!(relation)
      if relation.respond_to?(:merge) && Config.merge_relation
        @relation = @relation.merge(relation)
      end
    end

    class_methods do
      def call(*args)
        new(*args).call_all
      end
    end
  end
end