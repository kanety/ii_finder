describe IIFinder::Base do
  let :finder do
    CoactiveItemFinder
  end

  it 'lookups coactors' do
    expect(finder.new.coactors).to eq([Coactors::NameFinder, Coactors::AgeFinder])
  end

  it 'calls coactors' do
    expect(finder.call(Item.all, name: 'item_1', age: 0..100).size).to eq(1)
  end
end
