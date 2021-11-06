describe IIFinder::Scope do
  context 'model' do
    it 'finds records' do
      expect(Item.finder_scope(id: 1).count).to eq(1)
    end
  end
end
