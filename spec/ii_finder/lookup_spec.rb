describe IIFinder::Lookup do
  context 'finder' do
    let :finder do
      UsersFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(User)
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
      Lookups::UsersFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(Lookups::User)
    end
  end

  context 'inherited finder' do
    let :finder do
      Lookups::SharedUsersFinder
    end

    it 'lookups superclass model' do
      expect(finder.lookup).to eq(User)
    end
  end

  context 'finder with model' do
    let :finder do
      Lookups::ModelSetFinder
    end

    it 'lookups model' do
      expect(finder.lookup).to eq(User)
    end
  end
end
