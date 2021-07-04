class Callbacks::BeforeFinder < UsersFinder
  before_call do
    @relation.where!(id: 1)
  end
end
