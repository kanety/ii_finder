class Callbacks::AfterFinder < ItemsFinder
  after_call do
    @relation.where!(id: 1)
  end
end
