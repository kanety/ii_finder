class Callbacks::BeforeFinder < ItemsFinder
  before_call do
    @relation.where!(id: 1)
  end
end
