class Callbacks::AfterFinder < UsersFinder
  after_call do
    @relation.where!(id: 1)
  end
end
