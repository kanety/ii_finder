class ItemsFinder < IIFinder::Base
  parameters :id, :name, :order
  parameters :query

  def id(value)
    @relation.where(id: value)
  end

  def name(value)
    @relation.where(name: value)
  end

  def order(value)
    @relation.order(value[:column] => value[:direction])
  end

  def query(hash)
    hash
  end
end
