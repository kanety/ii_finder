class Coactors::NameFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation.where(name: value)
  end
end
