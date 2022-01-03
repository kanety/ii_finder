class Callbacks::AfterAllFinder < ItemsFinder
  after_all do
    @context.relation = @context.relation.where(id: 1)
  end
end
