class Coactors::AgeFinder < IIFinder::Base
  parameters :age

  def age(value)
    @relation.where(age: value)
  end
end
