class Callbacks::BeforeAllFinder < ItemsFinder
  before_all do
    @context.relation = @context.relation.where(id: 1)
  end
end
