class Callbacks::BeforeAssignFinder < ItemsFinder
  before_call do
    @relation = @relation.where(id: 1)
  end
end
