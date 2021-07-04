class Callbacks::AroundFinder < UsersFinder
  around_call do |instance, block|
    @relation.where!(id: 1)
    block.call
  end
end
