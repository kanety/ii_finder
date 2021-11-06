class ChainItemFinder < IIFinder::Base
  chain Chains::NameFinder, Chains::AgeFinder
end
