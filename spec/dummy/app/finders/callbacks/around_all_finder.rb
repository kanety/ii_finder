class Callbacks::AroundAllFinder < ItemsFinder
  around_all do |instance, block|
    @context.relation = @context.relation.where(id: 1)
    block.call
  end
end
