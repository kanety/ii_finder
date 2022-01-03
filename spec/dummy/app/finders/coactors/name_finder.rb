class Coactors::NameFinder < IIFinder::Base
  parameters :name

  context :results, default: []

  before_call do
    @context.results << 'Name'
  end

  def name(value)
    @relation.where(name: value)
  end
end
