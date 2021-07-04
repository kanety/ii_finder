describe IIFinder::Callbacks do
  context 'before' do
    let :finder do
      Callbacks::BeforeFinder
    end

    it 'calls callback' do
      expect(finder.call.size).to eq(1)
    end
  end

  context 'after' do
    let :finder do
      Callbacks::AfterFinder
    end

    it 'calls callback' do
      expect(finder.call.size).to eq(1)
    end
  end

  context 'around' do
    let :finder do
      Callbacks::AroundFinder
    end

    it 'calls callback' do
      expect(finder.call.size).to eq(1)
    end
  end
end
