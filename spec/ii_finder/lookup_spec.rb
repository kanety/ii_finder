describe IIFinder::Lookup do
  context 'finder' do
    let :finder do
      ItemsFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(Item)
    end
  end

  context 'finder of nonexistent model' do
    let :finder do
      Lookups::NonexistentFinder
    end

    it 'returns nil' do
      expect(finder.lookup).to eq(nil)
    end
  end

  context 'inherited finder' do
    let :finder do
      Lookups::ItemsFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(Lookups::Item)
    end
  end

  context 'inherited finder' do
    let :finder do
      Lookups::SharedItemsFinder
    end

    it 'lookups superclass model' do
      expect(finder.lookup).to eq(Item)
    end
  end

  context 'finder with model' do
    let :finder do
      Lookups::ModelSetFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(Item)
    end
  end
end
