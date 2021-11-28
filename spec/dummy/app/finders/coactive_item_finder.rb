class CoactiveItemFinder < IIFinder::Base
  model Item
  coact Coactors::NameFinder, Coactors::AgeFinder
end
