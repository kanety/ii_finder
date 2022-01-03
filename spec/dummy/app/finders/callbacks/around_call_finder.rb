class Callbacks::AroundCallFinder < ItemsFinder
  around_call do |instance, block|
    @relation = @relation.where(id: 1)
    block.call
  end
end
