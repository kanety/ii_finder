class ChainByMethodFinder < IIFinder::Base
  chain :chain_finders

  def chain_finders
    [Chains::NameFinder]
  end
end
