# frozen_string_literal: true

module IIFinder
  module Core
    extend ActiveSupport::Concern
    include Coactive::Initializer

    included do
      self.context_class = IIFinder::Context
      context :relation, output: true
      context :criteria, :model, :table
    end

    def initialize(*args)
      if args[0].is_a?(self.class.context_class)
        super(args[0])
      else
        relation, criteria = Core.resolve_args(self, *args)
        model = relation.klass
        table = model.arel_table if model.respond_to?(:arel_table)
        super(relation: relation, criteria: criteria, model: model, table: table)
      end
    end

    def call_all
      coactors.each do |finder|
        relation = finder.call(@context)
        @context.relation = @context.relation.merge(relation) if relation.respond_to?(:merge)
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
        finder = new(*args).tap(&:call_all)
        finder.context.relation
      end
    end

    class << self
      def resolve_args(finder, *args)
        if args.size == 0 || args.size == 1
          model = finder.class.lookup
          raise IIFinder::Error.new("could not find model for #{finder.class}") unless model
          return model.all,  args[0] || {}
        else
          return args[0], args[1]
        end
      end
    end
  end
end