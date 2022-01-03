class Coactors::AgeFinder < IIFinder::Base
  parameters :age

  context :results, default: []

  before_call do
    @context.results << 'Age'
  end

  def age(value)
    @relation.where(age: value)
  end
end
