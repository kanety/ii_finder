class Chains::NameFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation.where(name: value)
  end
end
