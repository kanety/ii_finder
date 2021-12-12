describe IIFinder::Railtie do
  it 'clears cache when reloaded' do
    IIFinder::Lookup.call(Item)
    expect(IIFinder::Lookup.cache.size).not_to eq(0)

    Rails.application.reloader.reload!
    expect(IIFinder::Lookup.cache.size).to eq(0)

    IIFinder::Lookup.call(Item)
    expect(IIFinder::Lookup.cache.size).not_to eq(0)
  end
end
