class CoactiveItemFinder < IIFinder::Base
  model Item
  coact Coactors::NameFinder, Coactors::AgeFinder

  context :results, default: []

  before_call do
    @context.results << 'Main'
  end
end
