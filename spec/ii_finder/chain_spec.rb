describe IIFinder::Chain do
  let :finder do
    ChainItemFinder
  end

  it 'calls chained finders' do
    expect(finder.call(Item.all, name: 'item_1', age: 0..100).size).to eq(1)
  end

  context 'chain by class' do
    let :finder do
      ChainItemFinder.new(Item.all, id: 1)
    end

    it 'lookups chained finders' do
      expect(finder.lookup).to eq([Chains::NameFinder, Chains::AgeFinder])
    end
  end

  context 'chain by method' do
    let :finder do
      ChainByMethodFinder.new(Item.all, id: 1)
    end

    it 'lookups chained finders' do
      expect(finder.lookup).to eq([Chains::NameFinder])
    end
  end

  context 'chain by block' do
    let :finder do
      ChainByBlockFinder.new(Item.all, id: 1)
    end

    it 'lookups chained finders' do
      expect(finder.lookup).to eq([Chains::NameFinder])
    end
  end
end
