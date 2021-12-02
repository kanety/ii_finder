class Callbacks::AroundAssignFinder < ItemsFinder
  around_call do |instance, block|
    block.call
    @relation = @relation.where(id: 1)
  end
end
