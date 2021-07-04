class UsersFinder < IIFinder::Base
  parameters :id, :name, :order 

  def id(value)
    @relation.where(id: value)
  end

  def name(value)
    @relation.where(name: value)
  end

  def order(value)
    @relation.order(value[:column] => value[:direction])
  end
end
